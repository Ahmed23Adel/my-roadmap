//
//  CompletedTaskYoutubePlaylistState.swift
//  myRoadmap
//
//  Created by ahmed on 18/05/2025.
//

import Foundation

class CompletedTaskYoutubePlaylistState: CompletedTaskObjectState, YoutubePlaylistState {
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
        throw TaskYoutubePlaylistError.cannotSetVideosWatchedInCompletedYoutubePlaylistState
    }
    
    func increaseNumVideosWatchedBy(_ videosWatched: Int) throws {
        throw TaskYoutubePlaylistError.cannotSetVideosWatchedInCompletedYoutubePlaylistState
    }
}
