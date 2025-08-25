//
//  InProgressTaskBookViewModel.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import Foundation
import Combine

class InProgressTaskBookViewModel: ObservableObject {
    private let roadmap: Roadmap
    private let taskBook: TaskBook
    
    @Published var pagesToAdd: Int = 0
    
    init(roadmap: Roadmap, taskBook: TaskBook) {
        self.roadmap = roadmap
        self.taskBook = taskBook
    }
    
    var readingProgress: Int {
        guard taskBook.numPagesInBook > 0 else { return 0 }
        return Int((Double(taskBook.numPagesRead) / Double(taskBook.numPagesInBook)) * 100)
    }
    
    func incrementPagesToAdd() {
        pagesToAdd += 1
    }
    
    func decrementPagesToAdd() {
        if pagesToAdd > 0 {
            pagesToAdd -= 1
        }
    }
    
    func updatePagesRead() {
//        let newPagesRead = min(taskBook.numPagesRead + pagesToAdd, taskBook.numPagesInBook)
//        taskBook.numPagesRead = newPagesRead
//        pagesToAdd = 0
//        
//        // Auto-complete if all pages are read
//        if newPagesRead >= taskBook.numPagesInBook {
//            completeTask()
//        }
    }
    
    func completeTask() {
//        taskBook.completedAt = Date()
//        taskBook.taskStatus = .completed
//        taskBook.numPagesRead = taskBook.numPagesInBook // Ensure 100% completion
        // Additional completion logic here
    }
}

