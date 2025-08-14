//
//  TaskArticleView.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import SwiftUI

struct TaskYoutubePlaylistView: View {
    var taskYoutube: TaskYoutubePlaylist
    @StateObject var viewModel: TaskYoutubePlaylistViewModel
    
    init(taskYoutube: TaskYoutubePlaylist) {
        self.taskYoutube = taskYoutube
        self._viewModel = StateObject(wrappedValue: TaskYoutubePlaylistViewModel(taskYoutube: taskYoutube))
        
    }
    
    var body: some View {
        GenericViewTaskType(singleTask: viewModel.taskYoutube, Tasklabel: viewModel.getLabel(), imgName: viewModel.getImgName())
    }
}

#Preview {
    PreviewContentTaskYoutube()
}

struct PreviewContentTaskYoutube: View {
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
            
                
            return AnyView(TaskYoutubePlaylistView(taskYoutube: taskYoutube))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
