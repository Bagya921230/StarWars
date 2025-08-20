# Star Wars

Star Wars is an iOS application that provides information about various planets. The app fetches data from a remote API and stores it locally using Core Data.

## Features

- Fetch and display a list of planets from a remote API.
- Offline access to planet data using Core Data for local storage.
- Image caching to reduce network usage.
- Network monitoring to handle connectivity changes.
- Localization support for multiple languages.

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern, which helps in separating the UI from the business logic, making the code more maintainable and testable.

## Technologies

- **SwiftUI**: For building the user interface.
- **Combine**: For handling asynchronous events and data binding.
- **Core Data**: For local data persistence.
- **Swift Concurrency**: Using `async/await` for asynchronous network calls.

## Prerequisites

- **Xcode**: Version 13.3 or higher is required.

## Installation

### Clone the repository
```
git clone https://github.com/Bagya921230/StarWars.git
cd StarWars
```

### Open the project
Open PlanetExplorer.xcodeproj in Xcode.

### Build the project
- Select the desired build target (Device, Simulator)
- If running on a device ensure the development team is selected in Signing & Capabilities section.

### Run the project
Click the Run button in the top left corner of Xcode or press Cmd + R.

## Requirements
- iOS 15.6+
- XCode 13.3+
- Swift 5+

## Contact
For futher details, please contact bngunawardana@gmail.com
