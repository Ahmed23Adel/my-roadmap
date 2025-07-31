//
//  NotStartedTaskArticleState.swift
//  myRoadmap
//
//  Created by ahmed on 19/05/2025.
//
/*
    the setter for article name and article link are the same for all the three states
    so it's implmented for all the states using extension the protocol file
 */
import Foundation

class NotStartedTaskArticleState: NotStartedTaskObjectState, TaskArticleState {
    weak var taskArticle: TaskArticle?
    
    required init(taskArticle: TaskArticle) {
        self.taskArticle = taskArticle
        super.init(task: taskArticle)
        
    }
    @available(*, unavailable, message: "use init(taskArticle) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }
    
    override func startTask() throws {
        try super.startTask()
        taskArticle?._transitionToState(.inProgress)
    }
    
    
}
