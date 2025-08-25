//
//  NotStartedTaskYoutubeViewModel.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import Foundation
import Combine

class NotStartedTaskYoutubeViewModel: ObservableObject {
    private let roadmap: Roadmap
    private let taskYoutube: TaskYoutubePlaylist
    
    init(roadmap: Roadmap, taskYoutube: TaskYoutubePlaylist) {
        self.roadmap = roadmap
        self.taskYoutube = taskYoutube
    }
    
    func isPrevTaskCompleted() -> Bool {
        roadmap.isPrevTaskFinished(singleTask: self.taskYoutube)
    }
    
    func startTask() {
        do{
            try! taskYoutube.startTask()
            roadmap.updateChanges()
        }
    }
}

