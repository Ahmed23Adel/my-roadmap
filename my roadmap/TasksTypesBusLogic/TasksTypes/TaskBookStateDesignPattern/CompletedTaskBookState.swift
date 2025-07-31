//
//  CompletedTaskBookState.swift
//  myRoadmap
//
//  Created by ahmed on 17/05/2025.
//

import Foundation

class CompletedTaskBookState: CompletedTaskObjectState ,TaskBookState{
    var taskBook: TaskBook?
    
    required init(taskBook: TaskBook) {
        self.taskBook = taskBook
        super.init(task: taskBook)
        
    }
    
    @available(*, unavailable, message: "use init(taskBook) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }

    
    func setNumPagesRead(_ pagesRead: Int) throws {
        throw TaskBookError.cannotSetPagesReadInCompletedTaskBookState
    }
    
    func increaseNumPagesReadBy(_ pagesRead: Int) throws {
        throw TaskBookError.cannotSetPagesReadInCompletedTaskBookState
    }
    
    
    
}
    
