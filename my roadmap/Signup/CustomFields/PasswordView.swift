//
//  PasswordView.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct PasswordView: View {
    @Binding var password: String
    @State private var isShown = false
    var body: some View {
        HStack{
            if isShown{
                TextField("Password", text: $password)
            } else{
                SecureField("Password", text: $password)
            }
            
            Button {
                isShown.toggle()
            } label: {
                Image(systemName: isShown ? "eye.slash" : "eye")
                    .foregroundColor(.blue)
            }
        }
    }
}
