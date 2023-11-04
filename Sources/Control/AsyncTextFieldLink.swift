//
//  AsyncTextFieldLink.swift
//  AsyncSwiftUI
//
//  Created by treastrain on 2023/11/04.
//

import Core
import SwiftUI

/// A control that requests text input from the user when pressed.
@available(watchOS 9.0, *)
@available(iOS, unavailable)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
public struct AsyncTextFieldLink<Label: View>: AsyncControl {
    public typealias Base = TextFieldLink<Label>
    package typealias Value = String
    
    private let priority: TaskPriority
    private let onSubmit: @Sendable (String) async -> Void
    private let base: (_ trigger: _AsyncControlTrigger<Value>?) -> Base
    
    @State private var trigger: _AsyncControlTrigger<Value>? = nil
    
    private init(
        priority: TaskPriority,
        @_inheritActorContext onSubmit: @escaping @Sendable (String) async -> Void,
        base: @escaping (_ trigger: _AsyncControlTrigger<Value>?) -> Base
    ) {
        self.priority = priority
        self.onSubmit = onSubmit
        self.base = base
    }
    
    public var body: some View {
        AsyncControlView(
            priority: priority,
            action: onSubmit,
            base: base(trigger)
        )
        .onPreferenceChange(_AsyncControlTriggerPreferenceKey.self) {
            trigger = $0
        }
    }
}

@available(watchOS 9.0, *)
@available(iOS, unavailable)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
extension AsyncTextFieldLink {
    /// Creates a TextFieldLink which when pressed will request text input from the user.
    ///
    /// - Parameters:
    ///   - prompt: Text which describes the reason for requesting text input.
    ///   - label: A view that describes the action of requesting text input.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - onSubmit: An action to perform when text input has been accepted and dismissed.
    public init(
        prompt: Text? = nil,
        @ViewBuilder label: @escaping () -> Label,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext onSubmit: @escaping @Sendable (String) async -> Void
    ) {
        self.init(
            priority: priority,
            onSubmit: onSubmit,
            base: { trigger in
                Base(prompt: prompt, label: label, onSubmit: { trigger?($0) })
            }
        )
    }
}

@available(watchOS 9.0, *)
@available(iOS, unavailable)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
extension AsyncTextFieldLink where Label == Text {
    /// Creates a TextFieldLink which when pressed will request text input from the user.
    /// - Parameters:
    ///   - titleKey: A key for the TextFieldLink's localized title, that describes the purpose of requesting text input.
    ///   - prompt: Text which describes the reason for requesting text input.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - onSubmit: An action to perform when text input has been accepted and dismissed.
    public init(
        _ titleKey: LocalizedStringKey,
        prompt: Text? = nil,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext onSubmit: @escaping @Sendable (String) async -> Void
    ) {
        self.init(
            priority: priority,
            onSubmit: onSubmit,
            base: { trigger in
                Base(titleKey, prompt: prompt, onSubmit: { trigger?($0) })
            }
        )
    }
    
    /// Creates a TextFieldLink which when pressed will request text input from the user.
    /// - Parameters:
    ///   - title: A string that describes the purpose of requesting text input.
    ///   - prompt: Text which describes the reason for requesting text input.
    ///   - priority: The task priority to use when creating the asynchronous task. The default priority is `userInitiated`.
    ///   - onSubmit: An action to perform when text input has been accepted and dismissed.
    @_disfavoredOverload
    public init<S>(
        _ title: S,
        prompt: Text? = nil,
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext onSubmit: @escaping @Sendable (String) async -> Void
    ) where S : StringProtocol {
        self.init(
            priority: priority,
            onSubmit: onSubmit,
            base: { trigger in
                Base(title, prompt: prompt, onSubmit: { trigger?($0) })
            }
        )
    }
}
