//
//  NotStartedTaskBookViewModel.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import Foundation
import Combine


class NotStartedTaskBookViewModel: ObservableObject {
    private let roadmap: Roadmap
    private let taskBook: TaskBook
    
    init(roadmap: Roadmap, taskBook: TaskBook) {
        self.roadmap = roadmap
        self.taskBook = taskBook
    }
    
    func isPrevTaskCompleted() -> Bool {
        roadmap.isPrevTaskFinished(singleTask: self.taskBook)
    }
    
    var readingProgress: Int {
        guard taskBook.numPagesInBook > 0 else { return 0 }
        return Int((Double(taskBook.numPagesRead) / Double(taskBook.numPagesInBook)) * 100)
    }
    
    func startTask() {
//        taskBook.startDate = Date()
//        taskBook.taskStatus = .inProgress
        // Additional start logic here
    }
}
