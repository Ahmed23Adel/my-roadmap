//
//  NotStartedTaskBookState.swift
//  myRoadmap
//
//  Created by ahmed on 17/05/2025.
//

import Foundation

class NotStartedTaskBookState: NotStartedTaskObjectState ,TaskBookState{
    weak var taskBook: TaskBook?
    
    required init(taskBook: TaskBook) {
        self.taskBook = taskBook
        super.init(task: taskBook)
        
    }
    
    @available(*, unavailable, message: "use init(taskBook) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }
    
    func setNumPagesRead(_ pagesRead: Int) throws {
        throw TaskBookError.cannotSetPagesReadInNotStartedTaskBookState
    }
    
    func increaseNumPagesReadBy(_ pagesRead: Int) throws {
        throw TaskBookError.cannotSetPagesReadInNotStartedTaskBookState
    }
    
    
    override func startTask() throws {
        try super.startTask()
        taskBook?._setNumPagesRead(0)
        taskBook?._transitionToState(.inProgress)
    }
}
