//
//  DrawableSingleTask.swift
//  my roadmap
//
//  Created by ahmed on 03/08/2025.
//

import SwiftUI

struct DrawableSingleTask: View {
    let singleTask: TaskObject
    var body: some View {
        if let taskArticle = singleTask as? TaskArticle {
            TaskArticleView(taskArticle: taskArticle)
        } else if let taskBook = singleTask as? TaskBook {
            TaskBookView(taskBook: taskBook)
        }else if let taskGoal = singleTask as? TaskGoal {
            TaskGoalView(taskGoal: taskGoal)
        } else if let taskYoutube = singleTask as? TaskYoutubePlaylist {
            TaskYoutubePlaylistView(taskYoutube: taskYoutube)
        }
    }
}

#Preview {
    PreviewContentDrawable()
}

struct PreviewContentDrawable: View {
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
            let taskGoal = try TaskGoal.createInProgressGoal(details: "any", imageLink: "", title: "finished", progress: 10, expectedStartDate: pastDate, startDate: pastDate, expectedDeadline: futureDate, taskStatus: .inProgress)
            
            
                
            return AnyView(TaskGoalView(taskGoal: taskGoal))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
