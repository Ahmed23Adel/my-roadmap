//
//  HomeView.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        ZStack{
            Image("backgroundgrid")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
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
            }
            VStack{
                Spacer()
                HStack{
                    Button{
                        viewModel.navigateToAddNewRoadmap()
                    } label: {
                        Image("add")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(.leading, 120)
                    }
                     Spacer()
                }
                
            }
        }
        .onAppear{
            viewModel.setCoordinator(coordinator: coordinator)
        }
    }
}

#Preview {
    HomeView()
}
