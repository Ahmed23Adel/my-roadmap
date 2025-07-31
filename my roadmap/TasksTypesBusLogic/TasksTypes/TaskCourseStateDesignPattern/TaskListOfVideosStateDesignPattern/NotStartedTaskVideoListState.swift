//
//  NotStartedTaskVideoListState.swift
//  myRoadmap
//
//  Created by ahmed on 21/05/2025.
//

import Foundation

class NotStartedTaskVideoListState: NotStartedTaskObjectState, TaskVideoListState {
    weak var taskVideoList: TaskVideoList?
    
    required init(taskVideoList: TaskVideoList) {
        self.taskVideoList = taskVideoList
        super.init(task: taskVideoList)
    }
    
    @available(*, unavailable, message: "use init(taskVideoList) instead.")
    required init(task: TaskObject) {
        fatalError("init(task:) has not been implemented")
    }
    
    func setNumVideosWatched(_ videosWatched: Int) throws {
        throw TaskVideoListError.cannotSetVideosWatchedInNotStartedTaskVideoListState
    }
    
    func increaseNumVideosWatchedBy(_ videosWatched: Int) throws {
        throw TaskVideoListError.cannotSetVideosWatchedInNotStartedTaskVideoListState
    }
    
    override func startTask() throws {
        try super.startTask()
        taskVideoList?._setNumVideosWatched(0)
        taskVideoList?._transitionToState(.inProgress)
    }
}
