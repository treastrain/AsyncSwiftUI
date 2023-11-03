//
//  AsyncControlView.swift
//  AsyncSwiftUI
//
//  Created by treastrain on 2023/11/03.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
package struct AsyncControlView<Base: View>: View {
    private let priority: TaskPriority
    private let action: @Sendable () async -> Void
    private let base: Base
    
    @State private var idValue: Bool? = nil
    
    @inlinable
    package init(
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable () async -> Void,
        base: Base
    ) {
        self.action = action
        self.priority = priority
        self.base = base
    }
    
    package var body: some View {
        base
            .preference(key: _AsyncControlTriggerPreferenceKey.self, value: .init(action: trigger))
            .task(id: idValue, priority: priority, performAction)
    }
    
    private func trigger() {
        if idValue == nil {
            idValue = true
        } else {
            idValue?.toggle()
        }
    }
    
    @Sendable
    private func performAction() async {
        guard idValue != nil else { return }
        await action()
    }
}
