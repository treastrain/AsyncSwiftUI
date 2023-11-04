//
//  _AsyncControlTriggerPreferenceKey.swift
//  AsyncSwiftUI
//
//  Created by treastrain on 2023/11/03.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
package struct _AsyncControlTriggerPreferenceKey<Value>: PreferenceKey {
    package static var defaultValue: _AsyncControlTrigger<Value> { fatalError("This property is not expected to be called.") }
    package static func reduce(value: inout _AsyncControlTrigger<Value>, nextValue: () -> _AsyncControlTrigger<Value>) { fatalError("This function is not expected to be called.") }
}
