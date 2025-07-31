//
//  CompletedTaskGoalState.swift
//  myRoadmap
//
//  Created by ahmed on 20/05/2025.
//

import Foundation

class CompletedTaskGoalState: CompletedTaskObjectState, GoalState {
    var taskGoal: TaskGoal?
    
    required init(taskGoal: TaskGoal) {
        self.taskGoal = taskGoal
        super.init(task: taskGoal)
    }
    
    @available(*, unavailable, message: "use init(goal) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }
    
    func setDetails(_ details: String) throws {
        self.taskGoal?._setDetails(details)
    }
    
    func setImageLink(_ imageLink: String?) throws {
        self.taskGoal?._setImageLink(imageLink)
    }
}
