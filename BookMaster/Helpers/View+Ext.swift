//
//  View+Ext.swift
//  BookMaster
//
//  Created by Nikita on 21.05.2026.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}
