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
                    } else if let taskBranch = singleTask as? TaskBranch {
                        // Render individual tasks from both branches directly
                        ForEach(taskBranch.parallelBranches, id: \.id) { listOfTasks in
                            ForEach(listOfTasks.tasks, id: \.id) { task in
                                DrawableSingleTask(singleTask: task)
                                    .position(x: task.posX, y: task.posY)
                            }
                        }
                        
                        // Render arrows for each list separately
                        ForEach(taskBranch.parallelBranches, id: \.id) { listOfTasks in
                            ForEach(0..<listOfTasks.tasks.count-1, id: \.self) { taskIndex in
                                let currentTask = listOfTasks.tasks[taskIndex]
                                let nextTask = listOfTasks.tasks[taskIndex + 1]
                                ArrowLineView(
                                    start: CGPoint(x: currentTask.posX, y: currentTask.posY + DrawableConstants.height/2), // Bottom of current task
                                    end: CGPoint(x: nextTask.posX, y: nextTask.posY - DrawableConstants.height/2)  // Top of next task
                                )
                            }
                        }
                    }
                }
                drawRoadmapArrows()
            }
            .frame(width: DrawableConstants.canvasWidth, height: DrawableConstants.canvasHeight)
        }
//        .ignoresSafeArertea()
    }
    
    @ViewBuilder
    private func drawRoadmapArrows() -> some View {
        // Start to first item
        if !roadmap.roadmap.isEmpty {
            ArrowLineView(
                start: CGPoint(x: xPosMid, y: yPosMid + DrawableConstants.startImgHeight/3.9),
                end: CGPoint(x: roadmap.roadmap[0].posX, y: roadmap.roadmap[0].posY - DrawableConstants.height/2) // Top of first task
            )
        }
        
        // Between roadmap items
        if roadmap.roadmap.count > 1 {
            ForEach(0..<roadmap.roadmap.count-1, id: \.self) { index in
                let current = roadmap.roadmap[index]
                let next = roadmap.roadmap[index + 1]
                
                if current is TaskObject && next is TaskBranch {
                    // Case 1: Task to Branch
                    let nextBranch = next as! TaskBranch
                    ArrowLineView(
                        start: CGPoint(x: current.posX, y: current.posY + DrawableConstants.height/2), // Bottom of current task
                        end: CGPoint(x: nextBranch.parallelBranches[0].tasks[0].posX, y: nextBranch.parallelBranches[0].tasks[0].posY - DrawableConstants.height/2) // Top of first task in first branch
                    )
                    ArrowLineView(
                        start: CGPoint(x: current.posX, y: current.posY + DrawableConstants.height/2), // Bottom of current task
                        end: CGPoint(x: nextBranch.parallelBranches[1].tasks[0].posX, y: nextBranch.parallelBranches[1].tasks[0].posY - DrawableConstants.height/2) // Top of first task in second branch
                    )
                } else if current is TaskBranch && next is TaskObject {
                    // Case 2: Branch to Task
                    let currentBranch = current as! TaskBranch
                    let currentList1LastItem = currentBranch.parallelBranches[0].tasks.last!
                    let currentList2LastItem = currentBranch.parallelBranches[1].tasks.last!
                    
                    ArrowLineView(
                        start: CGPoint(x: currentList1LastItem.posX, y: currentList1LastItem.posY + DrawableConstants.height/2), // Bottom of last task in first branch
                        end: CGPoint(x: next.posX, y: next.posY - DrawableConstants.height/2) // Top of next task
                    )
                    
                    ArrowLineView(
                        start: CGPoint(x: currentList2LastItem.posX, y: currentList2LastItem.posY + DrawableConstants.height/2), // Bottom of last task in second branch
                        end: CGPoint(x: next.posX, y: next.posY - DrawableConstants.height/2) // Top of next task
                    )
                } else if current is TaskBranch && next is TaskBranch {
                    // Case 3: Branch to Branch
                    let currentBranch = current as! TaskBranch
                    let nextBranch = next as! TaskBranch
                    
                    let currentList1LastItem = currentBranch.parallelBranches[0].tasks.last!
                    let currentList2LastItem = currentBranch.parallelBranches[1].tasks.last!
                    
                    // From first branch's last item to both branches of next
                    ArrowLineView(
                        start: CGPoint(x: currentList1LastItem.posX, y: currentList1LastItem.posY + DrawableConstants.height/2), // Bottom of last task in first branch
                        end: CGPoint(x: nextBranch.parallelBranches[0].tasks[0].posX, y: nextBranch.parallelBranches[0].tasks[0].posY - DrawableConstants.height/2) // Top of first task in next first branch
                    )
                    ArrowLineView(
                        start: CGPoint(x: currentList1LastItem.posX, y: currentList1LastItem.posY + DrawableConstants.height/2), // Bottom of last task in first branch
                        end: CGPoint(x: nextBranch.parallelBranches[1].tasks[0].posX, y: nextBranch.parallelBranches[1].tasks[0].posY - DrawableConstants.height/2) // Top of first task in next second branch
                    )
                    
                    // From second branch's last item to both branches of next
                    ArrowLineView(
                        start: CGPoint(x: currentList2LastItem.posX, y: currentList2LastItem.posY + DrawableConstants.height/2), // Bottom of last task in second branch
                        end: CGPoint(x: nextBranch.parallelBranches[0].tasks[0].posX, y: nextBranch.parallelBranches[0].tasks[0].posY - DrawableConstants.height/2) // Top of first task in next first branch
                    )
                    ArrowLineView(
                        start: CGPoint(x: currentList2LastItem.posX, y: currentList2LastItem.posY + DrawableConstants.height/2), // Bottom of last task in second branch
                        end: CGPoint(x: nextBranch.parallelBranches[1].tasks[0].posX, y: nextBranch.parallelBranches[1].tasks[0].posY - DrawableConstants.height/2) // Top of first task in next second branch
                    )
                } else if current is TaskObject && next is TaskObject {
                    // Case 4: Task to Task
                    ArrowLineView(
                        start: CGPoint(x: current.posX, y: current.posY + DrawableConstants.height/2), // Bottom of current task
                        end: CGPoint(x: next.posX, y: next.posY - DrawableConstants.height/2) // Top of next task
                    )
                }
            }
        }
    }
}
#Preview {
    let roadmap = Roadmap()
    roadmap.initTestableRoadmap()
    roadmap.calcEachTaskPosition()
    return RoadmapCanvasView(roadmap: roadmap)
}
