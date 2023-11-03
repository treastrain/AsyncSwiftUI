# treastrain/AsyncSwiftUI

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/treastrain/AsyncSwiftUI/blob/main/LICENSE)
![Swift: 5.9](https://img.shields.io/badge/Swift-5.9-F05138)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
![Platform: iOS 15.0+ | iPadOS 15.0+ | macOS 12.0+ | Mac Catalyst 15.0+ | tvOS 15.0+ | watchOS 8.0+ | visionOS 1.0+](https://img.shields.io/badge/Platform-iOS%2015.0%2B%20%7C%20iPadOS%2015.0%2B%20%7C%20macOS%2012.0%2B%20%7C%20Mac%20Catalyst%2015.0%2B%20%7C%20tvOS%2015.0%2B%20%7C%20watchOS%208.0%2B%20%7C%20visionOS%201.0%2B-lightgrey)
[![Twitter: @treastrain](https://img.shields.io/twitter/follow/treastrain?label=%40treastrain&style=social)](https://twitter.com/treastrain)

Wrappers for Swift Concurrency asynchronous actions on controls that enable user interaction specific to each platform and context provided by SwiftUI.

It's based on the following post: https://zenn.dev/treastrain/articles/3effccd39f4056

## Features
- ✅ Designed for Swift Concurrency and SwiftUI.
- ✅ Compatible with all Apple platforms (iPhone, iPod touch, iPad, Mac, Apple TV, Apple Watch, Apple Vision Pro).
- ✅ Automatically cancels the task and performs a new action on new user interaction.
- ✅ Automatically cancels the task after the view disappears before the action completes.
- ✅ Supports Sendable and inherits the Actor context.
- ✅ No dependencies.

## Samples
```swift
import AsyncSwiftUI

struct ContentView: View {
    @State private var isRunning = false
    
    var body: some View {
        AsyncButton(isRunning ? "Running..." : "Run") {
            isRunning = true
            defer { isRunning = false }
            do {
                print("START")
                try await Task.sleep(for: .seconds(2))
            } catch {
                print("ERROR:", error)
            }
            print("FINISH")
        }
        .disabled(isRunning)
    }
}
```

## Installation
To use this library in a Swift Package Manager project, add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/treastrain/AsyncSwiftUI", from: "0.1.0"),
```

Include `"AsyncSwiftUI"` as a dependency for your executable target:

```swift
.target(name: "<target>", dependencies: [
    .product(name: "AsyncSwiftUI", package: "AsyncSwiftUI"),
]),
```

Finally, add `import AsyncSwiftUI` to your source code (or replace the existing `import SwiftUI` with it).

## Components

### Controls and indicators

| SwiftUI                                                                                              | AsyncSwiftUI  | Available on                                                                                      |
|:-----------------------------------------------------------------------------------------------------|:--------------|:--------------------------------------------------------------------------------------------------|
| [`Button`](https://developer.apple.com/documentation/swiftui/button)                                 | `AsyncButton` | iOS 15.0+, iPadOS 15.0+, macOS 12.0+, Mac Catalyst 15.0+, tvOS 15.0+, watchOS 8.0+, visionOS 1.0+ |
| [`EditButton`](https://developer.apple.com/documentation/swiftui/editbutton)                         | (No need)     | ―                                                                                                 |
| [`PasteButton`](https://developer.apple.com/documentation/swiftui/pastebutton)                       | 🚧             | ―<!-- iOS 16.0+, iPadOS 16.0+, macOS 12.0+, Mac Catalyst 16.0+, visionOS 1.0+                           --> |
| [`RenameButton`](https://developer.apple.com/documentation/swiftui/renamebutton)                     | 🚧             | ―<!-- iOS 16.0+, iPadOS 16.0+, macOS 13.0+, Mac Catalyst 16.0+, tvOS 16.0+, watchOS 9.0+, visionOS 1.0+ --> |
| [`Link`](https://developer.apple.com/documentation/swiftui/link)                                     | (No need)     | ―                                                                                                 |
| [`ShareLink`](https://developer.apple.com/documentation/swiftui/sharelink)                           | (No need)     | ―                                                                                                 |
| [`TextFieldLink`](https://developer.apple.com/documentation/swiftui/textfieldlink)                   | 🚧             | ―<!-- watchOS 9.0+                                                                                      --> |
| [`HelpLink`](https://developer.apple.com/documentation/swiftui/helplink)                             | 🚧             | ―<!-- macOS 14.0+, visionOS 1.0+                                                                        --> |
| [`Slider`](https://developer.apple.com/documentation/swiftui/slider)                                 | 🚧             | ―<!-- iOS 15.0+, iPadOS 15.0+, macOS 12.0+, Mac Catalyst 15.0+, watchOS 8.0+, visionOS 1.0+             --> |
| [`Stepper`](https://developer.apple.com/documentation/swiftui/stepper)                               | 🚧             | ―<!-- iOS 15.0+, iPadOS 15.0+, macOS 12.0+, Mac Catalyst 15.0+, watchOS 9.0+, visionOS 1.0+             --> |
| [`Toggle`](https://developer.apple.com/documentation/swiftui/toggle)                                 | 🚧             | ―<!-- iOS 15.0+, iPadOS 15.0+, macOS 12.0+, Mac Catalyst 15.0+, tvOS 15.0+, watchOS 8.0+, visionOS 1.0+ --> |
| [`Picker`](https://developer.apple.com/documentation/swiftui/picker)                                 | (No need)     | ―                                                                                                 |
| [`DatePicker`](https://developer.apple.com/documentation/swiftui/datepicker)                         | (No need)     | ―                                                                                                 |
| [`MultiDatePicker`](https://developer.apple.com/documentation/swiftui/multidatepicker)               | (No need)     | ―                                                                                                 |
| [`ColorPicker`](https://developer.apple.com/documentation/swiftui/colorpicker)                       | (No need)     | ―                                                                                                 |
| [`Gauge`](https://developer.apple.com/documentation/swiftui/gauge)                                   | (No need)     | ―                                                                                                 |
| [`ProgressView`](https://developer.apple.com/documentation/swiftui/progressview)                     | (No need)     | ―                                                                                                 |
| [`ContentUnavailableView`](https://developer.apple.com/documentation/swiftui/contentunavailableview) | (No need)     | ―                                                                                                 |

### Menus and commands

| SwiftUI                                                                                              | AsyncSwiftUI  | Available on                                                                        |
|:-----------------------------------------------------------------------------------------------------|:--------------|:------------------------------------------------------------------------------------|
| [`Menu`](https://developer.apple.com/documentation/swiftui/menu)                                     | 🚧             | ―<!-- iOS 15.0+, iPadOS 15.0+, macOS 12.0+, Mac Catalyst 15.0+, tvOS 17.0+, visionOS 1.0+ --> |
| [`MenuButton`](https://developer.apple.com/documentation/swiftui/menubutton)                         | (No need)     | ―                                                                                   |
| [`PullDownButton`](https://developer.apple.com/documentation/swiftui/pulldownbutton)                 | (No need)     | ―                                                                                   |
| [`CommandMenu`](https://developer.apple.com/documentation/swiftui/commandmenu)                       | (No need)     | ―                                                                                   |
| [`CommandGroup`](https://developer.apple.com/documentation/swiftui/commandgroup)                     | (No need)     | ―                                                                                   |

## Note

The documentation comments included in this library, with some exceptions, are from [the SwiftUI entry in the Apple Developer Documentation](https://developer.apple.com/documentation/swiftui).
