//
//  TaskVideoListError.swift
//  myRoadmap
//
//  Created by ahmed on 21/05/2025.
//

import Foundation


enum TaskVideoListError: Error {
    case titleCannotBeEmpty
    case videosCountLessThanOrEqualToZero
    case videosWatchedLessThanZero
    case videosWatchedGreaterThanVideosCount
    case videosWatchedNotEqualToVideosCount
    case cannotSetVideosWatchedInNotStartedTaskVideoListState
    case cannotSetVideosWatchedInCompletedTaskVideoListState
    case videosWatchedIsGreaterThanZeroWhileNotStartedTaskVideoList
}

extension TaskVideoListError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .titleCannotBeEmpty:
            return "Title cannot be empty"
        case .videosCountLessThanOrEqualToZero:
            return "Videos count must be greater than zero"
        case .videosWatchedLessThanZero:
            return "Number of watched videos cannot be less than zero"
        case .videosWatchedGreaterThanVideosCount:
            return "Number of watched videos cannot be greater than total videos count"
        case .videosWatchedNotEqualToVideosCount:
            return "For a completed task, watched videos count must equal total videos count"
        case .cannotSetVideosWatchedInNotStartedTaskVideoListState:
            return "Cannot set watched videos count for a not started task"
        case .cannotSetVideosWatchedInCompletedTaskVideoListState:
            return "Cannot set watched videos count for a completed task"
        case .videosWatchedIsGreaterThanZeroWhileNotStartedTaskVideoList:
            return "Watched videos count must be zero for a not started task"
        }
    }
}
