//
//  InProgressTaskYoutubePlaylistState.swift
//  myRoadmap
//
//  Created by ahmed on 18/05/2025.
//

import Foundation

class InProgressTaskYoutubePlaylistState: InProgressTaskObjectState, YoutubePlaylistState {
    var youtubePlaylist: TaskYoutubePlaylist?
    
    required init(youtubePlaylist: TaskYoutubePlaylist) {
        self.youtubePlaylist = youtubePlaylist
        super.init(task: youtubePlaylist)
    }
    
    @available(*, unavailable, message: "use init(youtubePlaylist) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }
    
    func setNumVideosWatched(_ videosWatched: Int) throws {
        try youtubePlaylist?.validateNumVideosWatched(videosWatched)
        youtubePlaylist?._setNumVideosWatched(videosWatched)
    }
    
    func increaseNumVideosWatchedBy(_ videosWatched: Int) throws {
        let newVideosWatched = (youtubePlaylist?.numVideosWatched ?? 0) + videosWatched
        try setNumVideosWatched(newVideosWatched)
    }
    
    override func completeTask() throws {
        try super.completeTask()
        youtubePlaylist?._setNumVideosWatched(youtubePlaylist?.videoCount ?? 0)
        youtubePlaylist?._transitionToState(.completed)
        
    }
}
