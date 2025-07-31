//
//  GoalState.swift
//  myRoadmap
//
//  Created by ahmed on 20/05/2025.
//

import Foundation


// In progress state for this task is dummy, it must go directly from not started to completed
protocol GoalState {
    var taskGoal: TaskGoal? { get set }
    
    init(taskGoal: TaskGoal)
    
    func setDetails(_ details: String) throws
    func setImageLink(_ imageLink: String?) throws
}

