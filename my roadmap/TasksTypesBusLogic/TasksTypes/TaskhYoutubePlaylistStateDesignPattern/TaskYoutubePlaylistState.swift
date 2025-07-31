//
//  TaskYoutubePlaylistState.swift
//  myRoadmap
//
//  Created by ahmed on 18/05/2025.
//

import Foundation

protocol YoutubePlaylistState {
    var youtubePlaylist: TaskYoutubePlaylist? { get set }
    
    init(youtubePlaylist: TaskYoutubePlaylist)
    
    func setNumVideosWatched(_ videosWatched: Int) throws
    func increaseNumVideosWatchedBy(_ videosWatched: Int) throws
}
