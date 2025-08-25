//
//  MainHomeTaskYoutubeEditor.swift
//  my roadmap
//
//  Created by ahmed on 15/08/2025.
//

import SwiftUI

struct MainHomeTaskYoutubeEditor: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskYoutube: TaskYoutubePlaylist
    
    var body: some View {
        switch taskYoutube.taskStatus {
        case .notStarted:
            NotStartedTaskYoutubeView(roadmap: roadmap, taskYoutubePlaylist: taskYoutube)
        case .inProgress:
            InProgressTaskYoutubeView(roadmap: roadmap, taskYoutubePlaylist: taskYoutube)
        case .completed:
            CompletedTaskYoutubeView(roadmap: roadmap, taskYoutubePlaylist: taskYoutube)
        }
    }
}


