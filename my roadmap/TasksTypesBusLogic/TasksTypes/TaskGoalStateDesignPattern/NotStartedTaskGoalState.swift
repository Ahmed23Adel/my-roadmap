//
//  NotStartedTaskGoalState.swift
//  myRoadmap
//
//  Created by ahmed on 20/05/2025.
//

import Foundation
class NotStartedTaskGoalState: NotStartedTaskObjectState, GoalState {
    weak var taskGoal: TaskGoal?
    
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
        try TaskGoal.validateImageLink(imageLink)
        self.taskGoal?._setImageLink(imageLink)
    }
    
    
    override func startTask() throws {
        try super.startTask()
        taskGoal?._transitionToState(.inProgress)
    }
    
    
}
