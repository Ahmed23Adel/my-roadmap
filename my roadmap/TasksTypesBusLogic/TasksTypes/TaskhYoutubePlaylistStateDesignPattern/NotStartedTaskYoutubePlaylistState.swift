//
//  NotStartedTaskYoutubePlaylistState.swift
//  myRoadmap
//
//  Created by ahmed on 18/05/2025.
//

import Foundation

class NotStartedTaskYoutubePlaylistState: NotStartedTaskObjectState, YoutubePlaylistState {
    weak var youtubePlaylist: TaskYoutubePlaylist?
    
    required init(youtubePlaylist: TaskYoutubePlaylist) {
        self.youtubePlaylist = youtubePlaylist
        super.init(task: youtubePlaylist)
    }
    
    @available(*, unavailable, message: "use init(youtubePlaylist) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }
    
    func setNumVideosWatched(_ videosWatched: Int) throws {
        throw TaskYoutubePlaylistError.cannotSetVideosWatchedInNotStartedYoutubePlaylistState
    }
    
    func increaseNumVideosWatchedBy(_ videosWatched: Int) throws {
        throw TaskYoutubePlaylistError.cannotSetVideosWatchedInNotStartedYoutubePlaylistState
    }
    
    override func startTask() throws {
        try super.startTask()
        youtubePlaylist?._setNumVideosWatched(0)
        youtubePlaylist?._transitionToState(.inProgress)
    }
}
