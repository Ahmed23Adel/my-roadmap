//
//  InProgressTaskVideoListState.swift
//  myRoadmap
//
//  Created by ahmed on 21/05/2025.
//


import Foundation

class InProgressTaskVideoListState: InProgressTaskObjectState, TaskVideoListState {
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
        try taskVideoList?.validateNumVideosWatched(videosWatched)
        taskVideoList?._setNumVideosWatched(videosWatched)
    }
    
    func increaseNumVideosWatchedBy(_ videosWatched: Int) throws {
        let newVideosWatched = (taskVideoList?.numVideosWatched ?? 0) + videosWatched
        try setNumVideosWatched(newVideosWatched)
    }
    
    override func completeTask() throws {
        try super.completeTask()
        taskVideoList?._setNumVideosWatched(taskVideoList?.videosCount ?? 0)
        taskVideoList?._transitionToState(.completed)
    }
}
