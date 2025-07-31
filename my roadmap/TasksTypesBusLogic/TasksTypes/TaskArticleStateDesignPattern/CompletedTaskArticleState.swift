//
//  CompletedTaskArticleState.swift
//  myRoadmap
//
//  Created by ahmed on 19/05/2025.
//

import Foundation
class CompletedTaskArticleState: CompletedTaskObjectState, TaskArticleState{
    var taskArticle: TaskArticle?
    
    required init(taskArticle: TaskArticle) {
        self.taskArticle = taskArticle
        super.init(task: taskArticle)
        
    }
    

    @available(*, unavailable, message: "use init(taskArticle) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }
}

