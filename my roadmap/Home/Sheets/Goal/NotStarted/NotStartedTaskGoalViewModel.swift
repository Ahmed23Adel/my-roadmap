//
//  NotStartedTaskGoalViewModel.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import Foundation
import Combine
class NotStartedTaskGoalViewModel: ObservableObject {
    @Published var roadmap: Roadmap
    @Published var taskGoal: TaskGoal
    
    init(roadmap: Roadmap, taskGoal: TaskGoal) {
        self.roadmap = roadmap
        self.taskGoal = taskGoal
    }
    
    func startTask() {
        do{
            try! taskGoal.startTask()
            roadmap.updateChanges()
        }
    }
    
    func startAndCompleteTask() {
        do{
            startTask()
            try! taskGoal.completeTask()
            roadmap.updateChanges()
        }
    }
}
