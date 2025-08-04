//
//  RoadmapCanvasView.swift
//  my roadmap
//
//  Created by ahmed on 03/08/2025.
//

import SwiftUI
struct RoadmapCanvasView: View {
    @State private var xPosMid: CGFloat = DrawableConstants.startRoadmapX // 390
    @State private var yPosMid: CGFloat = DrawableConstants.startRoadmapY // 430
    
    @ObservedObject var roadmap: Roadmap
    @StateObject private var viewModel: RoadmapCanvasViewModel
    
    
    
    init(roadmap: Roadmap) {
        self._roadmap = ObservedObject(initialValue: roadmap)
        self._viewModel = StateObject(wrappedValue: RoadmapCanvasViewModel(roadmap: roadmap))
    }
    
    var body: some View {
        ScrollView([.vertical, .horizontal], showsIndicators: true) {
            ZStack {                
                Image("start")
                    .resizable()
                    .frame(width: DrawableConstants.startImgWidth, height: DrawableConstants.startImgHeight)
                    .position(x: xPosMid, y: yPosMid)
                
                ForEach(0..<viewModel.roadmap.count, id: \.self) { index in
                    let singleTask = roadmap[index]
                    if let taskObject = singleTask as? TaskObject {
                        DrawableSingleTask(singleTask: taskObject)
                            .position(x: singleTask.posX, y: singleTask.posY)
                    } else{
                        DrawableListOfTasks(listOfTasks: ((singleTask as? TaskBranch)?.parallelBranches[0])!)
                        DrawableListOfTasks(listOfTasks: ((singleTask as? TaskBranch)?.parallelBranches[1])!)
                    }
                }
            }
            .frame(width: DrawableConstants.canvasWidth, height: DrawableConstants.canvasHeight)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    let roadmap = Roadmap()
    roadmap.initTestableRoadmap()
    
    return RoadmapCanvasView(roadmap: roadmap)
}
