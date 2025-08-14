//
//  AddRoadmapStep2Roadmap.swift
//  my roadmap
//
//  Created by ahmed on 06/08/2025.
//

import SwiftUI

struct AddRoadmapStep2RoadmapView: View {
    @EnvironmentObject private var coordinator: AddNewRoadmapCoordinator
    @StateObject var viewModel = AddRoadmapStep2RoadmapViewModel()
    
    var body: some View {
        ZStack{
            waitingRoadmapCanvas(viewModel: viewModel)
            ChooseTaskTypeCoordinatorView()
                    
            
            HStack{
                Spacer()
                TopRightGenericButton(imgName: "save", backFunc: viewModel.save)
                TopRightBackButton(backFunc: viewModel.back)
                

            }
            
            
            
        }
        .onAppear{
            viewModel.setCoordinator(coordinator: coordinator)
        }
        
    }
    
}

#Preview {
    let mockCoordinator = AddNewRoadmapCoordinator()
    return AddRoadmapStep2RoadmapView()
        .environmentObject(mockCoordinator)
}
