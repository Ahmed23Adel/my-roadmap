//
//  FixedStyleButtonViewGeneric.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import SwiftUI


struct FixedStyleButtonViewGeneric: View {
    var isDisabled: Bool
    var title: String
    var function: () -> Void = {}
    
    var body: some View {
        Button(title){
            function()
        }
        .buttonStyle(.borderedProminent)
        .disabled(isDisabled)
        .frame(width: 150, height: 60)
        .controlSize(.large)
        .tint(Color.yellow)
    }
}
#Preview {
    FixedStyleButtonViewGeneric(isDisabled: false, title: "Submit") {
        print("Button tapped!")
    }
}


