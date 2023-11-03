//
//  AsyncButton.swift
//  AsyncSwiftUI
//
//  Created by treastrain on 2023/11/03.
//

import Core
import SwiftUI

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
