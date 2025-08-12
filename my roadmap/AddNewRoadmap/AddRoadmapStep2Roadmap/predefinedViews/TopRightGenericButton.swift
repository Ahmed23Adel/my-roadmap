//
//  TopRightGenericButton.swift
//  my roadmap
//
//  Created by ahmed on 12/08/2025.
//

import SwiftUI

struct TopRightGenericButton: View {
    var imgName: String = ""
    var backFunc: () -> Void
    var body: some View {
        VStack{
            HStack{
//                Spacer()
                Button{
                    backFunc()
                } label: {
                    HStack{
                        Image(imgName)
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
    TopRightGenericButton(imgName: "back"){
        
    }
}
