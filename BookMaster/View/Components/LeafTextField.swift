//
//  LeafTextField.swift
//  BookMaster
//
//  Created by Nikita on 26.05.2026.
//

import SwiftUI

struct LeafTextField: View {
    
    let isSecure: Bool
    let title: String
    @Binding var text: String
    @State private var isSecureField: Bool
    
    init(isSecure: Bool, title: String, text: Binding<String>) {
        self.isSecure = isSecure
        self.title = title
        self._text = text
        self.isSecureField = isSecure
    }
    
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField(title, text: $text)
            } else {
                TextField(title, text: $text)
            }
            Spacer()
            if isSecure {
                Button(action: {
                    isSecureField.toggle()
                }) {
                    Image(systemName: isSecureField ? "eye.fill" : "eye.slash.fill")
                        .resizable()
                        .frame(width: 26.5, height: 16.5)
                }
                .tint(.darkBlue)
            }
        }
        .padding(.horizontal,25)
        .padding(.vertical, 21)
        .background {
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 18,
                                                      bottomLeading: 0,
                                                      bottomTrailing: 18,
                                                      topTrailing: 0))
            .fill(.white)
            .stroke(.lightGray2)
        }
    }
}

//#Preview {
//    LeafTextField(isSecure: true, title: "Insert password", text: .constant(""))
//}
