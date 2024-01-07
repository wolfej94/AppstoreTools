//
//  NotificationManager.swift
//  
//
//  Created by James Wolfe on 04/01/2024.
//

import UIKit

class NotificationManager {

    // MARK: - Variables
    private let updateNotificationIdentifier = "UpdateNotification"
    
    // MARK: - Initializers
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if !success {
                print(error?.localizedDescription ?? "Registration failed")
            }
        }
    }

    // MARK: - Actions

    /// Send a local push notification to the user immediately indicating there is an update available for the app, attached to the notification if the app info which can be used to handle the notification at a later date when the user interacts with it.
    /// - Parameter app: App information pertaining to the current app's bundle identifier
    func notifyUserOfUpdate(for app: AppInfoResponse) {
        let content = UNMutableNotificationContent()
        content.title = "Update Available"
        content.body = "A new version of \(app.trackCensoredName) is available to download."
        content.userInfo = ["appstore_url": app.appstoreURL.absoluteString]
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [updateNotificationIdentifier])
        UNUserNotificationCenter.current().add(
            UNNotificationRequest(
                identifier: updateNotificationIdentifier,
                content: content,
                trigger: nil
            ),
            withCompletionHandler: { error in
                print(error?.localizedDescription ?? "")
            }
        )
    }
}
