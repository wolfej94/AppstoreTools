// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import BackgroundTasks
import StoreKit

public class AppstoreTools {
    
    // MARK: - Variables
    private let bundle: Bundle
    private let userDefaults: UserDefaults
    private let updateTaskIdentifier = "BackgroundUpdateCheck"
    private let notificationManager = NotificationManager()
    private let calendar: Calendar
    private var timer: Timer?
    
    private var launchNumber: Int {
        get {
            return userDefaults.integer(forKey: "LaunchNumber")
        }
        set {
            userDefaults.set(newValue, forKey: "LaunchNumber")
        }
    }
    
    private var scheduleDateComponents: DateComponents {
        get {
            let hour = userDefaults.integer(forKey: "BackgroundUpdateHour")
            let minute = userDefaults.integer(forKey: "BackgroundUpdateMinute")
            let second = userDefaults.integer(forKey: "BackgroundUpdateSecond")
            return .init(hour: hour, minute: minute, second: second)
        }
        set {
            userDefaults.set(newValue.hour ?? .zero, forKey: "BackgroundUpdateHour")
            userDefaults.set(newValue.minute ?? .zero, forKey: "BackgroundUpdateMinute")
            userDefaults.set(newValue.second ?? .zero, forKey: "BackgroundUpdateSecond")
        }
    }
    
    // MARK: - Initializers
    public init(bundle: Bundle = .main, userDefaults: UserDefaults = .standard, calendar: Calendar = .current) {
        self.bundle = bundle
        self.calendar = calendar
        self.userDefaults = userDefaults
        self.launchNumber += 1
        NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: nil,
            queue: .main,
            using: onEnterBackground(_:)
        )
        NotificationCenter.default.addObserver(
            forName: UIApplication.willTerminateNotification,
            object: nil,
            queue: .main,
            using: onEnterBackground(_:)
        )
        NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: .main,
            using: onEnterForeground(_:)
        )
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: updateTaskIdentifier,
            using: .main
        ) { [weak self] task in
            self?.handleBackgroundTask(task)
        }
    }
    
    // MARK: - Utilities
    
    /// Handles the triggering of the `BackgroundUpdateCheck` background task
    /// - Parameter task: The triggered task
    private func handleBackgroundTask(_ task: BGTask) {
        guard task.identifier == updateTaskIdentifier else { return }
        Task {
            do {
                if try await needsUpdate() {
                    let info = try await getAppInformation()
                    await MainActor.run {
                        self.notificationManager.notifyUserOfUpdate(for: info)
                    }
                }
            } catch {
                task.setTaskCompleted(success: false)
            }
            task.setTaskCompleted(success: true)
        }
    }
    
    /// Code to be ran when the app enters the foreground
    /// - Parameter notification: Notification that gets sent via the notification center when the app enters the foreground
    private func onEnterForeground(_ notification: Notification? = nil) {
        timer?.invalidate()
        guard let interval = scheduleDateComponents.timeUntilNextOccurrence() else {
            return
        }
        print("foreground timer scheduled in \(interval)s")
        timer = .scheduledTimer(
            withTimeInterval: interval,
            repeats: false,
            block: { _ in
                Task { [weak self] in
                    guard let self = self else { return }
                    let info = try await getAppInformation()
                    if try await self.needsUpdate(appInfo: info) {
                        await MainActor.run { [weak self] in
                            self?.notificationManager.notifyUserOfUpdate(for: info)
                        }
                    }
                }
            }
        )
    }
    
    /// Code to be ran when the app enters the background
    /// - Parameter notification: Notification that gets sent via the notification center when the app enters the background
    private func onEnterBackground(_ notification: Notification? = nil) {
        timer?.invalidate()
        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: updateTaskIdentifier)
        try? scheduleDailyUpdateCheck(for: scheduleDateComponents)
    }
    
    // MARK: - Actions
    
    /// Gets the current version string for an app from appstore connect using https://itunes.apple.com/lookup?bundleId=your_bundle_id_here
    public func getAppInformation() async throws -> AppInfoResponse {
        var components = URLComponents(string: "https://itunes.apple.com/lookup")!
        components.queryItems = [.init(name: "bundleId", value: bundle.bundleIdentifier)]
        let url = components.url!
        let data = try await URLSession.shared.data(from: url).0
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ssZ")
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let result = try decoder.decode(AppInfoParentResponse.self, from: data).results.first else {
            throw "No result for bundle ID \(bundle.bundleIdentifier ?? "")"
        }
        return result
    }
    
    /// If the the currently tracked number of launches is a multiple of the provided integer and is not zero the app requests a review for the app from the user
    /// - Parameter launchMultiple: The multiple that we check against the tracked number of launches in order to dictate whether a review is requested
    public func scheduleReview(onLaunchMultiplesOf launchMultiple: Int) {
        if launchNumber != .zero && launchNumber.isMultiple(of: launchMultiple) {
            requestReview()
        }
    }
    
    /// Immediately requests a review for the app from the user
    public func requestReview() {
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                DispatchQueue.main.async {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    
    /// Compares the current version to the one in the bundle and indicates whether the app needs updating or not
    public func needsUpdate(appInfo: AppInfoResponse? = nil) async throws -> Bool {
        guard let currentVersion = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            throw "Invalid version number on device"
        }
        let latestVersion = if let appInfo = appInfo {
            appInfo.version
        } else {
            try await getAppInformation().version
        }
        return currentVersion.compare(latestVersion, options: .numeric) == .orderedAscending
    }
    
    /// Schedules a background task to check if the app needs an update at a given hour, minute and second. If  it does it schedules a notification to send to the user in order to inform them of the update
    /// - Parameter time: date components containing an hour, minute and second values (if any are nil it defaults to zero)
    public func scheduleDailyUpdateCheck(for time: DateComponents) throws {
        scheduleDateComponents = time
        if [.background].contains(UIApplication.shared.applicationState) {
            let request = BGAppRefreshTaskRequest(identifier: updateTaskIdentifier)
            request.earliestBeginDate = Calendar.current.nextDate(after: .init(), matching: scheduleDateComponents, matchingPolicy: .nextTime)
            try BGTaskScheduler.shared.submit(request)
        } else {
            onEnterForeground()
        }
    }
    
}
