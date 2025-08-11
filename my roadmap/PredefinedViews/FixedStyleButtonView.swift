//
//  FixedStyleButtonView.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import SwiftUI

struct FixedStyleButtonView: View {
    var isDisabled: Bool
    var function: () -> Void = {}
    
    var body: some View {
        FixedStyleButtonViewGeneric(isDisabled: isDisabled, title: "Submit", function: function)
    }
}
#Preview {
    FixedStyleButtonView(isDisabled: false) {
        print("Button tapped!")
    }
}
