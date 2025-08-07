//
//  waitingRoadmapCanvas.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import SwiftUI
import Combine

struct waitingRoadmapCanvas: View {
    @ObservedObject var viewModel: AddRoadmapStep2RoadmapViewModel
    var body: some View {
        VStack{
            if viewModel.isCoordinatorSet{
                RoadmapCanvasView(roadmap: viewModel.getRoadmap())
            } else{
                FixedProgressView()
            }
        }
    }
}

#Preview {
    var viewModel =  AddRoadmapStep2RoadmapViewModel()
    waitingRoadmapCanvas(viewModel: viewModel)
}
