//
//  CompletedTaskYoutubeViewModel.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import Foundation
import Combine

class CompletedTaskYoutubeViewModel: ObservableObject{
    private let roadmap: Roadmap
    private let taskYoutubePlaylist: TaskYoutubePlaylist
    @Published var videosToAdd: Int = 0
    
    var watchingProgress: Int {
        guard taskYoutubePlaylist.numVideosWatched > 0 else { return 0 }
        return Int((Double(taskYoutubePlaylist.numVideosWatched) / Double(taskYoutubePlaylist.videoCount)) * 100)
    }
    init(roadmap: Roadmap, taskYoutubePlaylist: TaskYoutubePlaylist) {
        self.roadmap = roadmap
        self.taskYoutubePlaylist = taskYoutubePlaylist
    }
    
    
    
    func isPrevTaskCompleted() -> Bool {
        roadmap.isPrevTaskFinished(singleTask: self.taskYoutubePlaylist)
    }
    
    func incrementVideosToAdd(){
        videosToAdd += 1
    }
    
}
