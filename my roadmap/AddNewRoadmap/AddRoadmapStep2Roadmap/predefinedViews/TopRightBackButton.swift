//
//  TopRightBackButton.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import SwiftUI

struct TopRightBackButton: View {
    var backFunc: () -> Void
    var body: some View {
       TopRightGenericButton(imgName: "back", backFunc: backFunc)
    }
}

#Preview {
    
    TopRightBackButton{
        
    }
}
