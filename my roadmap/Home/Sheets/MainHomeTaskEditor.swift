//
//  MainHomeTaskEditor.swift
//  my roadmap
//
//  Created by ahmed on 15/08/2025.
//

import SwiftUI

struct MainHomeTaskEditor: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var singleTask: TaskObject
    var body: some View {
        if let taskArticle = singleTask as? TaskArticle{
            MainHomeTaskArticleEditor(roadmap: roadmap, taskArticle: taskArticle)
        } else if let taskBook = singleTask as? TaskBook{
            MainHomeTaskBookEditor(roadmap: roadmap, taskBook: taskBook)
        } else if let taskGoal = singleTask as? TaskGoal{
            MainHomeTaskGoalEditor(roadmap: roadmap, taskGoal: taskGoal)
        } else if let taskYoutube = singleTask as? TaskYoutubePlaylist{
            MainHomeTaskYoutubeEditor(roadmap: roadmap, taskYoutube: taskYoutube)
        }
    }
}

#Preview {
    PreviewContentMainHomeTaskEditor()
}

struct PreviewContentMainHomeTaskEditor: View {
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
            let taskYoutube = try TaskYoutubePlaylist.createInProgressYoutubePlaylist(playlistName: "HTML course", videoCount: 30, numVideosWatched: 10, linkToYoutube: "https://www.youtube.com/watch?v=8q0cyaYtzC4&t=901s", title: "watch this video", progress: 30, expectedStartDate: pastDate, startDate: pastDate, expectedDeadline: futureDate, taskStatus: .inProgress)
            
                
            return AnyView(MainHomeTaskEditor(roadmap: Roadmap(), singleTask: taskYoutube))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
