//
//  AsyncButton.swift
//  AsyncSwiftUI
//
//  Created by treastrain on 2023/11/03.
//

import Core
import SwiftUI

/// A control that initiates an action.
/// - SeeAlso: [`SwiftUI.Button`](https://developer.apple.com/documentation/swiftui/button)
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct AsyncButton<Label: View>: AsyncControl {
    public typealias Base = Button<Label>
    
    private let priority: TaskPriority
    private let action: @Sendable () async -> Void
    private let base: (_ trigger: _AsyncControlTrigger?) -> Base
    
    @State private var trigger: _AsyncControlTrigger? = nil
    
    private init(
        priority: TaskPriority,
        @_inheritActorContext action: @escaping @Sendable () async -> Void,
        base: @escaping (_ trigger: _AsyncControlTrigger?) -> Base
    ) {
        self.priority = priority
        self.action = action
        self.base = base
    }
    
    public var body: some View {
        AsyncControlView(
            priority: priority,
            action: action,
            base: base(trigger)
        )
        .onPreferenceChange(_AsyncControlTriggerPreferenceKey.self) {
            trigger = $0
        }
    }
}

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension AsyncButton {
    /// Creates a button that displays a custom label.
    ///
    /// - Parameters:
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user triggers the button.
    ///   - label: A view that describes the purpose of the button's `action`.
    public init(
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(action: { trigger?() }, label: label)
            }
        )
    }
}

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension AsyncButton where Label == Text {
    /// Creates a button that generates its label from a localized string key.
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes the purpose of the button's `action`.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user triggers the button.
    public init(
        _ titleKey: LocalizedStringKey,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(titleKey, action: { trigger?() })
            }
        )
    }
    
    /// Creates a button that generates its label from a string.
    /// - Parameters:
    ///   - title: A string that describes the purpose of the button's `action`.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user triggers the button.
    @_disfavoredOverload
    public init<S>(
        _ title: S,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) where S : Swift.StringProtocol {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(title, action: { trigger?() })
            }
        )
    }
}

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension AsyncButton where Label == SwiftUI.Label<Text, Image> {
    /// Creates a button that generates its label from a localized string key and system image name.
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes the purpose of the button's `action`.
    ///   - systemImage: The name of the image resource to lookup.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user triggers the button.
    public init(
        _ titleKey: LocalizedStringKey,
        systemImage: String,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(titleKey, systemImage: systemImage, action: { trigger?() })
            }
        )
    }
    
    /// Creates a button that generates its label from a string and system image name.
    /// - Parameters:
    ///   - title: A string that describes the purpose of the button's `action`.
    ///   - systemImage: The name of the image resource to lookup.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user triggers the button.
    @_disfavoredOverload
    public init<S>(
        _ title: S,
        systemImage: String,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) where S : StringProtocol {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(title, systemImage: systemImage, action: { trigger?() })
            }
        )
    }
}

@available(iOS 17.0, macOS 14.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
extension AsyncButton where Label == SwiftUI.Label<Text, Image> {
    /// Creates a button that generates its label from a localized string key and image resource.
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes the purpose of the button's `action`.
    ///   - image: The image resource to lookup.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user triggers the button.
    public init(
        _ titleKey: LocalizedStringKey,
        image: ImageResource,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(titleKey, image: image, action: { trigger?() })
            }
        )
    }
    
    /// Creates a button that generates its label from a string and image resource.
    /// - Parameters:
    ///   - title: A string that describes the purpose of the button's `action`.
    ///   - image: The image resource to lookup.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user triggers the button.
    @_disfavoredOverload
    public init<S>(
        _ title: S,
        image: ImageResource,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) where S : Swift.StringProtocol {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(title, image: image, action: { trigger?() })
            }
        )
    }
}

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension AsyncButton {
    /// Creates a button with a specified role that displays a custom label.
    /// - Parameters:
    ///   - role: An optional semantic role that describes the button. A value of `nil` means that the button doesn't have an assigned role.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user interacts with the button.
    ///   - label: A view that describes the purpose of the button's `action`.
    public init(
        role: ButtonRole?,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(role: role, action: { trigger?() }, label: label)
            }
        )
    }
}

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension AsyncButton where Label == Text {
    /// Creates a button with a specified role that generates its label from a localized string key.
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes the purpose of the button's `action`.
    ///   - role: An optional semantic role describing the button. A value of `nil` means that the button doesn't have an assigned role.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user triggers the button.
    public init(
        _ titleKey: LocalizedStringKey,
        role: ButtonRole?,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(titleKey, role: role, action: { trigger?() })
            }
        )
    }
    
    /// Creates a button with a specified role that generates its label from a string.
    /// - Parameters:
    ///   - title: A string that describes the purpose of the button's `action`.
    ///   - role: An optional semantic role describing the button. A value of `nil` means that the button doesn't have an assigned role.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user interacts with the button.
    @_disfavoredOverload
    public init<S>(
        _ title: S,
        role: ButtonRole?,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) where S : StringProtocol {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(title, role: role, action: { trigger?() })
            }
        )
    }
}

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension AsyncButton where Label == SwiftUI.Label<Text, Image> {
    /// Creates a button with a specified role that generates its label from a localized string key and a system image.
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes the purpose of the button's `action`.
    ///   - systemImage: The name of the image resource to lookup.
    ///   - role: An optional semantic role describing the button. A value of `nil` means that the button doesn't have an assigned role.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user triggers the button.
    public init(
        _ titleKey: LocalizedStringKey,
        systemImage: String,
        role: ButtonRole?,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(titleKey, systemImage: systemImage, role: role, action: { trigger?() })
            }
        )
    }
    
    /// Creates a button with a specified role that generates its label from a string and a system image and an image resource.
    /// - Parameters:
    ///   - title: A string that describes the purpose of the button's `action`.
    ///   - systemImage: The name of the image resource to lookup.
    ///   - role: An optional semantic role describing the button. A value of `nil` means that the button doesn't have an assigned role.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user interacts with the button.
    @_disfavoredOverload
    public init<S>(
        _ title: S,
        systemImage: String,
        role: ButtonRole?,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) where S : StringProtocol {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(title, systemImage: systemImage, role: role, action: { trigger?() })
            }
        )
    }
}

@available(iOS 17.0, macOS 14.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
extension AsyncButton where Label == SwiftUI.Label<Text, Image> {
    /// Creates a button with a specified role that generates its label from a localized string key and an image resource.
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes the purpose of the button's `action`.
    ///   - image: The image resource to lookup.
    ///   - role: An optional semantic role describing the button. A value of `nil` means that the button doesn't have an assigned role.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user triggers the button.
    public init(
        _ titleKey: LocalizedStringKey,
        image: ImageResource,
        role: ButtonRole?,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(titleKey, image: image, role: role, action: { trigger?() })
            }
        )
    }
    
    /// Creates a button with a specified role that generates its label from a string and an image resource.
    /// - Parameters:
    ///   - title: A string that describes the purpose of the button's `action`.
    ///   - image: The image resource to lookup.
    ///   - role: An optional semantic role describing the button. A value of `nil` means that the button doesn't have an assigned role.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - action: The action to perform when the user interacts with the button.
    @_disfavoredOverload
    public init<S>(
        _ title: S,
        image: ImageResource,
        role: ButtonRole?,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void
    ) where S : Swift.StringProtocol {
        self.init(
            priority: priority,
            action: action,
            base: { trigger in
                Base(title, image: image, role: role, action: { trigger?() })
            }
        )
    }
}
