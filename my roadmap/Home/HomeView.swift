//
//  HomeView.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var mainCoordinator: Coordinator
    @EnvironmentObject var homeCoordinator: HomeCoordinator
    var body: some View {
        ZStack{ // START: ZStack
            Image("backgroundgrid")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{ // START: VStack for raodmapCanvas
                ZStack{
                    Text(viewModel.getRoadmapName())
                        .font(.title)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.ultraThickMaterial)
                                .blur(radius: 250)
                        )
                }
                
                RoadmapCanvasView(roadmap: viewModel.getRoadmap())
                    .clipped()
            } // END: VStack for raodmapCanvas
            VStack{ // START: VStack for add button
                Spacer()
                HStack{ // START: HStack
                    Button{
                        viewModel.navigateToAddNewRoadmap()
                    } label: {
                        Image("add")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(.leading, 120)
                    }
                    Spacer()
                    Button{
                        viewModel.navigateToSettings()
                    } label: {
                        Image("settings")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 120)
                    }
                    
                    
                     
                    
                } // END: HStack
                
            } // END: VStack for add button
        }  // END: ZStack
        .onAppear{
            viewModel.setMainCoordinator(coordinator: mainCoordinator)
            viewModel.setHomeCoordinator(coordinator: homeCoordinator)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Coordinator())
}
