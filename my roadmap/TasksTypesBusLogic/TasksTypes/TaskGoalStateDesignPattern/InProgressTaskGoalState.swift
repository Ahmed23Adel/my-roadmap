//
//  InProgressTaskGoalState.swift
//  myRoadmap
//
//  Created by ahmed on 20/05/2025.
//

import Foundation

class InProgressTaskGoalState: InProgressTaskObjectState, GoalState {
    var taskGoal: TaskGoal?
    
    required init(taskGoal: TaskGoal) {
        self.taskGoal = taskGoal
        super.init(task: taskGoal)
    }
    
    @available(*, unavailable, message: "use init(goal) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }
    
    // In progress state for this task is dummy, it must go directly from not started to completed
    func setDetails(_ details: String) throws {
        throw TaskGoalError.cannotUpdateDetailsInInProgressState
    }
    // In progress state for this task is dummy, it must go directly from not started to completed
    func setImageLink(_ imageLink: String?) throws {
        throw TaskGoalError.cannotUpdateImageLinkInInProgressState
    }
    
    override func completeTask() throws {
        try super.completeTask()
        taskGoal?._transitionToState(.completed)
    }
}
