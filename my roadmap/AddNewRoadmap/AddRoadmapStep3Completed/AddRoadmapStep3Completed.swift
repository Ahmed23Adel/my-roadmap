//
//  AddRoadmapStep3Completed.swift
//  my roadmap
//
//  Created by ahmed on 06/08/2025.
//

import SwiftUI

struct AddRoadmapStep3Completed: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var isVisible = false
    var body: some View {
        VStack{
            Image("completed")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .padding()
            Text("Completed")
                .font(.headline)
        }
        .opacity(isVisible ? 1 : 0)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            withAnimation(.easeInOut(duration: 0.5)){
                isVisible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                coordinator.navigateTo(.home)
            }
            
        }
        
        
    }
}

#Preview {
    AddRoadmapStep3Completed()
}
