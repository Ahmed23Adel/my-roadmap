//
//  MainHomeTaskArticleEditor.swift
//  my roadmap
//
//  Created by ahmed on 15/08/2025.
//

import SwiftUI

struct MainHomeTaskArticleEditor: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskArticle: TaskArticle
    
    var body: some View {
        // Navigate to appropriate view based on status
        switch taskArticle.taskStatus {
        case .notStarted:
            NotStartedTaskArticleView(roadmap: roadmap, taskArticle: taskArticle)
        case .inProgress:
            InProgressTaskArticleView(roadmap: roadmap, taskArticle: taskArticle)
        case .completed:
            CompletedTaskArticleView(roadmap: roadmap, taskArticle: taskArticle)
        }
    }
}

#Preview {
    PreviewContentMainHomeTaskArticleEditor()
}

struct PreviewContentMainHomeTaskArticleEditor: View {
    var body: some View {
        do {
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskArticle = try TaskArticle.createInProgressArticle(
                articleName: "How to learn iOS",
                linkToArticle: "https://google.com",
                title: "Learn this",
                progress: 20,
                expectedStartDate: pastDate,
                startDate: pastDate,
                expectedDeadline: futureDate,
                taskStatus: .inProgress,

            )
            
            return AnyView(MainHomeTaskArticleEditor(roadmap: Roadmap(), taskArticle: taskArticle))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
