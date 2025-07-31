//
//  TaskYoutubePlaylistError.swift
//  myRoadmap
//
//  Created by ahmed on 18/05/2025.
//

import Foundation

enum TaskYoutubePlaylistError: Error {
    case titleCannotBeEmpty
    case videoCountLessThanOrEqualToZero
    case videosWatchedLessThanZero
    case videosWatchedGreaterThanVideoCount
    case cannotSetVideosWatchedInNotStartedYoutubePlaylistState
    case cannotSetVideosWatchedInCompletedYoutubePlaylistState
    case invalidYoutubeUrl
    case videosWatchedIsGreaterThanZeroWhileNotStartedYoutubePlaylist
    case playListNameCannotBeEmpty
    case numVideosWatchedCannotBeEqualOrGreaterThanVideoCountInProgressState
}
