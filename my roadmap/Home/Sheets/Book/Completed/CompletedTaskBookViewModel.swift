//
//  CompletedTaskBookViewModel.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import Foundation
import Combine



class CompletedTaskBookViewModel: ObservableObject {
    private let roadmap: Roadmap
    private let taskBook: TaskBook
    
    init(roadmap: Roadmap, taskBook: TaskBook) {
        self.roadmap = roadmap
        self.taskBook = taskBook
    }
    
    var completionSummary: String? {
        guard let startDate = taskBook.startDate,
              let completedDate = taskBook.completedAt else { return nil }
        
        let calendar = Calendar.current
        let daysDifference = calendar.dateComponents([.day], from: startDate, to: completedDate).day ?? 0
        
        let expectedDays = calendar.dateComponents([.day],
                                                 from: taskBook.expectedStartDate!,
                                                 to: taskBook.expectedDeadline!).day ?? 0
        
        if daysDifference <= expectedDays {
            return "Completed on time! You finished this book in \(daysDifference) days."
        } else {
            let overdueDays = daysDifference - expectedDays
            return "Completed \(overdueDays) days after the expected deadline. Total reading time: \(daysDifference) days."
        }
    }
}
