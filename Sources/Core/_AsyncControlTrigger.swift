//
//  _AsyncControlTrigger.swift
//  AsyncSwiftUI
//
//  Created by treastrain on 2023/11/03.
//

import Foundation

/// - Warning: This `Equatable` compliance is a dummy implementation added for use in `SwiftUI.View.onPreferenceChange(_:perform:)`.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
package struct _AsyncControlTrigger: Equatable {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    package func callAsFunction() {
        action()
    }
    
    package static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
