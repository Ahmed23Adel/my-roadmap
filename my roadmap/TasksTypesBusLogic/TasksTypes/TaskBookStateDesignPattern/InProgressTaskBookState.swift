//
//  InProgressTaskBookState.swift
//  myRoadmap
//
//  Created by ahmed on 17/05/2025.
//

import Foundation

class InProgressTaskBookState: InProgressTaskObjectState, TaskBookState{
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
        try taskBook?.validateNumPagesRead(pagesRead)
        taskBook?._setNumPagesRead(pagesRead)
    }
    
    func increaseNumPagesReadBy(_ pagesRead: Int) throws {
        let newPagesRead = (taskBook?.numPagesRead ?? 0) + pagesRead
        try setNumPagesRead(newPagesRead)
    }
    
    override func completeTask() throws {
        try super.completeTask()
        taskBook?._setNumPagesRead(taskBook?.numPagesInBook ?? 0)
        taskBook?._transitionToState(.completed)
        
    }
    
}
