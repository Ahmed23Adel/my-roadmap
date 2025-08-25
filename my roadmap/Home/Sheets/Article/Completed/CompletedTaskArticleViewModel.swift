//
//  CompletedTaskArticleViewModel.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import Foundation
import Combine


class CompletedTaskArticleViewModel: ObservableObject{
    
    @Published var roadmap: Roadmap
    @Published var taskArticle: TaskArticle
    
    init(roadmap: Roadmap, taskArticle: TaskArticle){
        self.roadmap = roadmap
        self.taskArticle = taskArticle
    }
    
}
