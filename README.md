## Overview 
An iOS application built using Swift, SwiftUI, and Swift Concurrency. The app implements a user listing screen, a registration form, and an offline screen, following provided Figma mockups and OpenAPI documentation.

### Features
- Splash screen and three UI screens based on the Figma design.
- Fetch users via API (GET /users) with pagination (6 users per page).
- Register a new user via POST /users with validation.
- The new user appears in the list after successful registration.
- An offline screen is shown when the device is not connected to the internet.

### Configuration and Customization
- Minimum iOS version: 17.0
- Portrait mode only
- No external configuration files — all settings are handled in Xcode.

### Dependencies and External Libraries
The project does not use any third-party libraries.
Technologies used:
- Swift
- SwiftUI – for UI layout
- Swift Concurrency (async/await) – for asynchronous API calls
- Foundation – standard iOS framework

###  Build Instructions
1. Clone the repository:
   ```
   git clone https://github.com/white4ocolate/TestTask.git
   ```
2. Open the project in Xcode:
   ```
   open TestTask/TestTask.xcodeproj
   ```
3. Make sure the TestTask scheme is selected and the target device/simulator is running iOS 17.0 or later.
4. Build and run the project using Cmd + R.

### ❗ Troubleshooting and Common Issues
| Issue    | Solution  |
| ---      | ---       |
| “There is no internet connection” error | Check your network connection or simulate offline mode manually. |
| Empty user list | Make sure the API is reachable and returning valid data. |
| Registration form not working | Check input formats (e.g., valid email, name, photo |

### Project Structure
- Extensions/ - Extensions for Color, Data, View
- Main/ - Root view of the app that manages global navigation using a shared Router.
- MainTabBar/ - Manages the layout and navigation between main app sections using a custom tab bar.
- NoConnection/ - A view that displays a no-internet-connection screen with a retry button.
- Pickers/ - Allows picking an image from the photo library or camera.
- Resources/ - Contains static resources: colors, fonts
- Routing/ - Responsible for navigation between screens and transition management.
- Services/ - Contains classes for working with APIs, network requests and other business logic.
- SplashScreen/ - Implementation of the splash screen shown when the application is launched.
- Tabs/ - Implements tab bars and associated screens or navigation.
- Validators/ - Utilities for validation.
- ViewComponent/ - Reused UI components (buttons, cells, forms, etc.).
- ViewModifiers/ - SwiftUI custom modifiers for styling and display logic.


