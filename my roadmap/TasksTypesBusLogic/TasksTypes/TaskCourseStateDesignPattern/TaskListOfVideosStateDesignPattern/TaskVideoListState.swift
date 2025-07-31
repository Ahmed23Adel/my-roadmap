//
//  TaskVideoListState.swift
//  myRoadmap
//
//  Created by ahmed on 21/05/2025.
//

import Foundation


protocol TaskVideoListState {
    var taskVideoList: TaskVideoList? { get set }
    
    init(taskVideoList: TaskVideoList)
    
    func setNumVideosWatched(_ videosWatched: Int) throws
    func increaseNumVideosWatchedBy(_ videosWatched: Int) throws
}
