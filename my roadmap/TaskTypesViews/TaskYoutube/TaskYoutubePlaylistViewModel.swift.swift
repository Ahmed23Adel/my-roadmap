//
//  TaskArticleViewModel.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import Foundation
import Combine

class TaskYoutubePlaylistViewModel: ObservableObject, GenericTaskType{
    @Published var taskYoutube: TaskYoutubePlaylist
    
    init(taskYoutube: TaskYoutubePlaylist){
        self.taskYoutube = taskYoutube
    }
    
    func getLabel() -> String {
        taskYoutube.playlistName
    }
    
    func getImgName() -> String {
        "youtube"
    }
}
