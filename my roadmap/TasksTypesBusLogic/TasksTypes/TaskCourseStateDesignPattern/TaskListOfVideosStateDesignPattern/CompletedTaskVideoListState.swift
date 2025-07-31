//
//  CompletedTaskVideoListState.swift
//  myRoadmap
//
//  Created by ahmed on 21/05/2025.
//
import Foundation

class CompletedTaskVideoListState: CompletedTaskObjectState, TaskVideoListState {
    var taskVideoList: TaskVideoList?
    
    required init(taskVideoList: TaskVideoList) {
        self.taskVideoList = taskVideoList
        super.init(task: taskVideoList)
    }
    
    @available(*, unavailable, message: "use init(taskVideoList) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }
    
    func setNumVideosWatched(_ videosWatched: Int) throws {
        throw TaskVideoListError.cannotSetVideosWatchedInCompletedTaskVideoListState
    }
    
    func increaseNumVideosWatchedBy(_ videosWatched: Int) throws {
        throw TaskVideoListError.cannotSetVideosWatchedInCompletedTaskVideoListState
    }
}
