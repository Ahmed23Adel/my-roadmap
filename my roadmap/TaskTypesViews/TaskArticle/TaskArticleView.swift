//
//  TaskArticleView.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import SwiftUI

struct TaskArticleView: View {
    var taskArticle: TaskArticle
    @StateObject var viewModel: TaskArticleViewModel
    
    init(taskArticle: TaskArticle) {
        self.taskArticle = taskArticle
        self._viewModel = StateObject(wrappedValue: TaskArticleViewModel(taskArticle: taskArticle))
        
    }
    
    var body: some View {
        GenericViewTaskType(taskBook: viewModel.taskArticle, Tasklabel: viewModel.getLabel(), imgName: viewModel.getImgName())
    }
}

#Preview {
    PreviewContentTaskArticle()
}

struct PreviewContentTaskArticle: View {
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
            let taskArticle = try TaskArticle.createInProgressArticle(
                articleName: "How to learn iOS", linkToArticle: "https://google.com", title: "Learn this", progress: 20, expectedStartDate: futureDate, startDate: pastDate, expectedDeadline: futureDate, taskStatus: .inProgress)
            
                
            return AnyView(TaskArticleView(taskArticle: taskArticle))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
