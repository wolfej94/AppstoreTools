# Appstore Tools

Appstore Tools is a Swift library designed to facilitate background update checks for iOS applications, providing a seamless user experience. It leverages Apple's BackgroundTasks framework to perform periodic checks for updates in the App Store and notifies users when an update is available.

## Installation

### Swift Package Manager
To integrate Appstore Tools into your Xcode project using Swift Package Manager, follow these steps:

- Open your Xcode project.
- Go to File > Swift Packages > Add Package Dependency.
- Enter the repository URL ([https://github.com/wolfej94/appstore-tools.git](https://github.com/wolfej94/AppstoreTools)) and click Next.
- Choose the version rule according to your preference and click Next.
- Confirm your selection and click Finish.

### Usage
- Import the AppstoreTools module in your Swift file.
`import AppstoreTools`
- Create an instance of AppstoreTools with optional parameters (bundle, UserDefaults, and Calendar).
- Call the scheduleDailyUpdateCheck(for:) method to set up background update checks.
```
let appstoreTools = AppstoreTools()
try? appstoreTools.scheduleDailyUpdateCheck(for: .init(hour: 3, minute: 0, second: 0))
```
- Implement the getAppInformation() method to retrieve app information from the App Store. (Note: a placeholder .testContent is provided for testing purposes.)
`let appInfo = try await appstoreTools.getAppInformation()`
- Use the needsUpdate(appInfo:) method to determine if an update is required.
```
if try await appstoreTools.needsUpdate(appInfo: appInfo) {
// Perform update-related actions
}
```
- Schedule automatic review prompts based on the number of launches.
```
// Request a review if the app has been launched a multiple of 5 times
appstoreTools.scheduleReview(onLaunchMultiplesOf: 5)
```
- Manually request a review.
```
// Request a review immediately
appstoreTools.requestReview()
```

### Example
```
import AppstoreTools

let appstoreTools = AppstoreTools()

// Schedule daily update check at 3:00 AM
try? appstoreTools.scheduleDailyUpdateCheck(for: .init(hour: 3, minute: 0, second: 0))

// Get app information and check for updates
let appInfo = try await appstoreTools.getAppInformation()
if try await appstoreTools.needsUpdate(appInfo: appInfo) {
// Perform update-related actions
}
```

## Requirements

iOS 13.0+
Xcode 12.0+
Swift 5.3+

## License

Appstore Tools is available under the MIT license. See the [LICENSE](https://github.com/wolfej94/AppstoreTools/blob/main/LICENSE) file for more info.

## Acknowledgments

This library utilizes Apple's BackgroundTasks framework and incorporates best practices for handling background tasks in iOS applications.

## Support

For any questions or issues, please open an issue or submit a pull request.

