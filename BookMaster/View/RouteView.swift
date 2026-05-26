//
//  ContentView.swift
//  BookMaster
//
//  Created by Nikita on 21.05.2026.
//

import SwiftUI

struct RouteView: View {
    @State var observed: Observed = .init()
    
    var body: some View {
        if observed.appState == .authorized {
            HomeView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.BG)
        } else {
            AuthView(routeObserved: observed)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(colors: [.lightBlueGradient, .darkBlueGradient],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
        }
    }
}

extension RouteView {
    @Observable class Observed {
        var appState: AppState = .unauthorized
    }
}

enum AppState {
    case unauthorized
    case authorized
}

//#Preview {
//    RouteView()
//}

