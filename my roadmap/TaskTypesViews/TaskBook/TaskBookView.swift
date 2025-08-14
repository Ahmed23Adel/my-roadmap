//
//  TaskBookView.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import SwiftUI

struct TaskBookView: View {
    var taskBook: TaskBook
    @StateObject var viewModel: TaskBookViewModel
    
    init(taskBook: TaskBook) {
        self.taskBook = taskBook
        self._viewModel = StateObject(wrappedValue: TaskBookViewModel(taskBook: taskBook))
        
    }
    
    var body: some View {
        GenericViewTaskType(singleTask: viewModel.taskBook, Tasklabel: viewModel.getLabel(), imgName: viewModel.getImgName())
    }
}

#Preview {
    PreviewContentTaskBook()
}

struct PreviewContentTaskBook: View {
    var body: some View {
        do {
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
            let taskBook = try TaskBook.createInProgressBook(
                bookName: "Clean code",
                numPagesInBook: 300,
                numPagesRead: 50,
                title: "Read book",
                progress: 50,
                expectedStartDate: pastDate,
                startDate: startDate,
                expectedDeadline: futureDate,
                taskStatus: .inProgress
            )
            return AnyView(TaskBookView(taskBook: taskBook))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
