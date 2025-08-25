//
//  NotStartedTaskArticleViewModel.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import Foundation
import Combine

class NotStartedTaskArticleViewModel: ObservableObject{
    @Published var roadmap: Roadmap
    @Published var taskArticle: TaskArticle
    
    init(roadmap: Roadmap, taskArticle: TaskArticle){
        self.roadmap = roadmap
        self.taskArticle = taskArticle
    }
    
    func isPrevTaskCompleted() -> Bool {
        roadmap.isPrevTaskFinished(singleTask: self.taskArticle)
    }
    
    func start(){
        print("start")
        do{
            try! taskArticle.startTask()
            roadmap.updateChanges()
        }
        
    }
}


