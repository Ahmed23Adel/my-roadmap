//
//  TaskArticleViewModel.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import Foundation
import Combine

class TaskArticleViewModel: ObservableObject, GenericTaskType{
    @Published var taskArticle: TaskArticle
    
    init(taskArticle: TaskArticle){
        self.taskArticle = taskArticle
    }
    
    func getLabel() -> String {
        taskArticle.articleName
    }
    
    func getImgName() -> String {
        "article"
    }
}
