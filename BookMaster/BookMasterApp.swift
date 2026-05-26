//
//  BookMasterApp.swift
//  BookMaster
//
//  Created by Nikita on 21.05.2026.
//

import SwiftUI

@main
struct BookMasterApp: App {
    var body: some Scene {
        WindowGroup {
            RouteView()
                .preferredColorScheme(.light)
        }
    }
}


let currentUserID: UUID = .init()
