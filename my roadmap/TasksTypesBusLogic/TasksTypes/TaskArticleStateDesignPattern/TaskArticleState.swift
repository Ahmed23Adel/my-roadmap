//
//  TaskArticleState.swift
//  myRoadmap
//
//  Created by ahmed on 19/05/2025.
//

import Foundation

protocol TaskArticleState{
    var taskArticle: TaskArticle? { get set }
    
    init(taskArticle: TaskArticle)
    
    func setArticleName(_ articleName: String)
    func setLinkToArticle(_ linkToArticle: String)
}


extension TaskArticleState{
    
    func setArticleName(_ articleName: String) {
        self.taskArticle?._setArticleName(articleName)
    }
    
    func setLinkToArticle(_ linkToArticle: String) {
        self.taskArticle?._setLinkToArticle(linkToArticle)
    }
    
}
