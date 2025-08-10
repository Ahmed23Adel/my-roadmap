//
//  MandatoryField.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import Foundation
import SwiftUI

struct MandatoryField: ViewModifier{
    let isRequired: Bool
    
    func body(content: Content) -> some View{
        HStack(alignment: .top, spacing: 4) {
            if isRequired {
                Text("*")
                    .foregroundColor(.red)
                    .font(.system(size: 16, weight: .medium))
            }
            content
        }
    }
}


extension View{
    func mandatoryField(_ isRequired: Bool = true) -> some View{
        self.modifier(MandatoryField(isRequired: isRequired))
    }
}
