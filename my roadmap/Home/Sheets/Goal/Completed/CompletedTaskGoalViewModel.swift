//
//  CompletedTaskGoalViewModel.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import Foundation
import Combine


class CompletedTaskGoalViewModel: ObservableObject {
    @Published var roadmap: Roadmap
    @Published var taskGoal: TaskGoal
    
    init(roadmap: Roadmap, taskGoal: TaskGoal) {
        self.roadmap = roadmap
        self.taskGoal = taskGoal
    }
    
    // Additional methods can be added here if needed for completed task goal functionality
    // For example: analytics, sharing completion, etc.
}
