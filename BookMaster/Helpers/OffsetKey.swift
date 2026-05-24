//
//  OffsetKey.swift
//  BookMaster
//
//  Created by Nikita on 21.05.2026.
//

import Foundation
import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
