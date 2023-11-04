//
//  _AsyncControlTrigger.swift
//  AsyncSwiftUI
//
//  Created by treastrain on 2023/11/03.
//

import Foundation

/// - Warning: This `Equatable` compliance is a dummy implementation added for use in `SwiftUI.View.onPreferenceChange(_:perform:)`.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
package struct _AsyncControlTrigger<Value>: Equatable {
    private let action: (_ value: Value) -> Void
    
    init(action: @escaping (_ value: Value) -> Void) {
        self.action = action
    }
    
    package func callAsFunction(_ value: Value) {
        action(value)
    }
    
    package func callAsFunction() where Value == Void {
        callAsFunction(())
    }
    
    package static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
