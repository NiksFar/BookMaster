//
//  AuthView.swift
//  BookMaster
//
//  Created by Nikita on 26.05.2026.
//

import SwiftUI

struct AuthView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirm: String = ""
    @State private var isAuth: Bool = true
    @Bindable var routeObserved: RouteView.Observed
    
    var body: some View {
        VStack(spacing: 12) {
            Image(.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 140)
                .clipShape(.circle)
            Text("Book Master")
                .font(.title).bold()
                .foregroundColor(.darkBlue)
                .padding(.top, 27)
                .padding(.bottom, 14)
            LeafTextField(isSecure: false,
                          title: "E-mail",
                          text: $email)
            LeafTextField(isSecure: true,
                          title: "Password",
                          text: $password)
            if !isAuth {
                LeafTextField(isSecure: true,
                              title: "Repeat password",
                              text: $confirm)
            }
            LeafButton(title: isAuth ? "Log In" : "Sign Up") {
                //TODO: Change App State
                routeObserved.appState = .authorized
            }
            .padding(.bottom, 9)
            Button(isAuth ? "Still not with us?" : "Already have an account") {
                withAnimation {
                    isAuth.toggle()
                }
            }
            .font(.callout)
            .tint(.darkGrey)
        }
        .padding(.horizontal, 43)
        .offset(y: -67.5)
    }
}

//#Preview {
//    RouteView()
//}
