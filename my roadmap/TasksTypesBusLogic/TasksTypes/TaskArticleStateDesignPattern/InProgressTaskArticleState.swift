//
//  InProgressTaskArticleState.swift
//  myRoadmap
//
//  Created by ahmed on 19/05/2025.
//

import Foundation
class InProgressTaskArticleState: InProgressTaskObjectState, TaskArticleState{
    weak var taskArticle: TaskArticle?
    
    required init(taskArticle: TaskArticle) {
        self.taskArticle = taskArticle
        super.init(task: taskArticle)
        
    }
    
    @available(*, unavailable, message: "use init(taskArticle) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }

    
    override func completeTask() throws {
        try super.completeTask()
        taskArticle?._transitionToState(.completed)
    }
}
