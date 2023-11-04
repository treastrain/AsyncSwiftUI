//
//  AsyncControlView.swift
//  AsyncSwiftUI
//
//  Created by treastrain on 2023/11/03.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
package struct AsyncControlView<Base: View, Value>: View {
    private let priority: TaskPriority
    private let action: @Sendable (_ value: Value) async -> Void
    private let base: Base
    
    @State private var idValue: IDValue? = nil
    
    @inlinable
    package init(
        priority: TaskPriority = .userInitiated,
        @_inheritActorContext action: @escaping @Sendable (_ value: Value) async -> Void,
        base: Base
    ) {
        self.action = action
        self.priority = priority
        self.base = base
    }
    
    package var body: some View {
        base
            .preference(key: _AsyncControlTriggerPreferenceKey.self, value: .init(action: trigger(newValue:)))
            .task(id: idValue, priority: priority, performAction)
    }
    
    private func trigger(newValue: Value) {
        idValue = .init(value: newValue)
    }
    
    @Sendable
    private func performAction() async {
        guard let value = idValue?.value else { return }
        await action(value)
    }
}

extension AsyncControlView {
    private struct IDValue: Identifiable, Equatable {
        fileprivate let id = UUID()
        fileprivate let value: Value
        
        fileprivate static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
    }
}
