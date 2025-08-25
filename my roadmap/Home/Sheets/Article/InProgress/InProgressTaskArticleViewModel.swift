//
//  InProgressTaskArticleViewModel.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import Foundation
import Combine

class InProgressTaskArticleViewModel: ObservableObject{
    @Published var roadmap: Roadmap
    @Published var taskArticle: TaskArticle
    
    init(roadmap: Roadmap, taskArticle: TaskArticle){
        self.roadmap = roadmap
        self.taskArticle = taskArticle
    }
    
    func completeTask(){
        do{
            try! taskArticle.completeTask()
        }
    }
    
}
