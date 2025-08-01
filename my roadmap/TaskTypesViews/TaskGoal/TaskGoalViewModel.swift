//
//  TaskGoalViewModel.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import Foundation
import Combine

class TaskGoalViewModel: ObservableObject, GenericTaskType{
    @Published var taskGoal: TaskGoal
    
    init(taskGoal: TaskGoal){
        self.taskGoal = taskGoal
    }
    
    func getLabel() -> String {
        taskGoal.title
    }
    
    func getImgName() -> String {
        "goal"
    }
}
