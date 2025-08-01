//
//  HomeViewModel.swift
//  my roadmap
//
//  Created by ahmed on 31/07/2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
    func getTaskBook() -> TaskBook{
        var currentDate: Date {
            return Date()
        }
        
        var pastDate: Date {
            return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        }
        
        var futureDate: Date {
            return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
        }
        let startDate = pastDate
        let taskBook = try! TaskBook.createInProgressBook(
            bookName: "Clean code",
            numPagesInBook: 300,
            numPagesRead: 50,
            title: "Read book",
            progress: 20, // Assuming 20% progress
            expectedStartDate: pastDate,
            startDate: startDate,
            expectedDeadline: futureDate,
            taskStatus: .inProgress
        )
        return taskBook
    }
}
