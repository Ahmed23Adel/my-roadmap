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
    
    
    
    func updatePagesRead() {
        do{
            try taskBook.validateNumPagesRead(taskBook.numPagesRead + pagesToAdd)
            try! taskBook.increaseNumPagesReadBy(pagesToAdd)
            pagesToAdd = 0
            roadmap.updateChanges()
            
        } catch {
            pagesToAdd = 0
        }
        
    }
    
    func completeTask() {
        do{
            try! taskBook.completeTask()
            roadmap.updateChanges()
        }
    }
}

