//
//  _AsyncControlTriggerPreferenceKey.swift
//  AsyncSwiftUI
//
//  Created by treastrain on 2023/11/03.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
package struct _AsyncControlTriggerPreferenceKey: PreferenceKey {
    package static let defaultValue = _AsyncControlTrigger(action: {})
    package static func reduce(value: inout _AsyncControlTrigger, nextValue: () -> _AsyncControlTrigger) {}
}
