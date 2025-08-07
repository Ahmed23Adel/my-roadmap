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
        VStack{
            HStack{
                Spacer()
                Button{
                    backFunc()
                } label: {
                    HStack{
                        Image("back")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                }
                .padding(15)
            }
            
            Spacer()
        }
    }
}

#Preview {
    
    TopRightBackButton{
        
    }
}
