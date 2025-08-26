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
    @AppStorage(GlobalConstants.selectedRoadmapKey) var defaultRoadmapName: String = ""
    
    var body: some View {
        ZStack{ // START: ZStack
            Image("backgroundgrid")
                .resizable()
                .scaledToFill()
                .blur(radius: 1)
                .overlay{
                    Color.black.opacity(0.15)
                }
                .ignoresSafeArea()
            
            VStack{ // START: VStack for roadmapCanvas
                ZStack{
                    Text(viewModel.getRoadmapName())
                        .font(.title)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.ultraThickMaterial)
                                .blur(radius: 250)
                        )
                }
                
                // FIXED: Conditional rendering based on loading state
                Group {
                    if viewModel.isLoadingRoadmap {
                        VStack {
                            ProgressView("Loading roadmap...")
                                .progressViewStyle(CircularProgressViewStyle())
                            Text("Please wait...")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        RoadmapCanvasView(roadmap: viewModel.getRoadmap(), showSheetFn: viewModel.showSheetForTask)
                            .clipped()
                    }
                }
            } // END: VStack for roadmapCanvas
            
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
                    .disabled(viewModel.isLoadingRoadmap)  // Disable during loading
                    
                    Spacer()
                    
                    Button{
                        viewModel.navigateToSettings()
                    } label: {
                        Image("settings")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 120)
                    }
                    .disabled(viewModel.isLoadingRoadmap)  // Disable during loading
                } // END: HStack
            } // END: VStack for add button
        }  // END: ZStack
        .onAppear{
            viewModel.setMainCoordinator(coordinator: mainCoordinator)
            viewModel.setHomeCoordinator(coordinator: homeCoordinator)
        }
        .sheet(isPresented: $viewModel.showSheet){
            // Only show sheet when not loading
            if !viewModel.isLoadingRoadmap {
                MainHomeTaskEditor(roadmap: viewModel.getRoadmap(), singleTask: viewModel.selectedSheet!)
            }
        }
        // as did set wasn't working
        // probably bcz
//        didSet only fires for direct property assignments in that specific instance
//        When View A changes the @AppStorage value, it updates UserDefaults
//        Your ViewModel's @AppStorage property gets the new value from UserDefaults, but this isn't considered a "set" operation - it's more like a "sync" operation
        // No didSet is triggered because the property wasn't explicitly assigned in that context
        .onChange(of: defaultRoadmapName) { newValue in
            print("HomeView: defaultRoadmapName changed to: \(newValue)")
            viewModel.updateRoadmapName(newValue)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Coordinator())
        .environmentObject(HomeCoordinator())
}
