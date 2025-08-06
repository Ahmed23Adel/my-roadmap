//
//  AddRoadmapStep1Name.swift
//  my roadmap
//
//  Created by ahmed on 06/08/2025.
//

import SwiftUI

struct AddRoadmapStep1NameView: View {
    @EnvironmentObject private var coordinator: AddNewRoadmapCoordinator
    @StateObject private var viewModel = AddRoadmapStep1NameViewModel()
    var body: some View {
        Form{
            TextField("Roadmap Name", text: $viewModel.name)
            
            HStack{
                Spacer()
                Button("Next"){
                    viewModel.tryToMoveToNextStep()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!viewModel.isFormValid())
                .frame(width: 150, height: 60)
                .controlSize(.large)
                .tint(Color.yellow)
                
                Spacer()
            }
            
        }
        .onAppear{
            viewModel.setCoordinator(coordinator: coordinator)
        }
        .alert(isPresented: $viewModel.showError){
            Alert(
                title:  Text("Error"),
                message: Text(viewModel.errorMsg),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
}

#Preview {
    AddRoadmapStep1NameView()
}
