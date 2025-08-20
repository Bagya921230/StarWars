# Planet Explorer

Planet Explorer is an iOS application that provides information about various planets. The app fetches data from a remote API and stores it locally using Core Data.

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

TBD
