//
//  TaskVideoList.swift
//  myRoadmap
//
//  Created by ahmed on 21/05/2025.
//

import Foundation

final class TaskVideoList: TaskObject {
    
    // MARK: - TaskVideoList properties
    private(set) var listName: String {
        didSet {
            super.markAsChanged()
        }
    }
    private(set) var videosCount: Int {
        didSet {
            super.markAsChanged()
        }
    }
    
    private(set) var numVideosWatched: Int {
        didSet {
            super.markAsChanged()
        }
    }
    
    // MARK: State properties
    var currentStateCasted: TaskVideoListState {
        if let notStartedState = currentState as? NotStartedTaskVideoListState {
            return notStartedState
        } else if let inProgressState = currentState as? InProgressTaskVideoListState {
            return inProgressState
        } else {
            return currentState as! CompletedTaskVideoListState
        }
    }
    
    
    // MARK: - Initialization
    private init(listName: String, videosCount: Int, numVideosWatched: Int,
         title: String, progress: Int, expectedStartDate: Date?,
         startDate: Date?, completed: Bool, completedAt: Date?,
                 expectedDeadline: Date?, taskStatus: TaskStatus, isOnCreation: Bool
    ) throws {
        self.listName = listName
        self.videosCount = videosCount
        self.numVideosWatched = numVideosWatched
        
        super.init(title: title,
                   progress: progress,
                   expectedStartDate: expectedStartDate,
                   startDate: startDate,
                   completed: completed,
                   completedAt: completedAt,
                   expectedDeadline: expectedDeadline,
                   taskStatus: taskStatus
        )
        
        if isOnCreation {
            super.initChangeStatusOnCreationofBook()
        }
        
    }
    
    // MARK: - Factory methods
    static func createNotStartedVideoList(listName: String, videosCount: Int,
                                     title: String, expectedStartDate: Date?, expectedDeadline: Date?) throws -> TaskVideoList {
        try TaskVideoList.validateInputsForNotStartedTaskVideoList(listName: listName, videosCount: videosCount, numVideosWatched: 0, expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, isOnCreation: true)
        let taskVideoList = try TaskVideoList(listName: listName,
                                    videosCount: videosCount,
                                    numVideosWatched: 0,
                                    title: title,
                                    progress: 0,
                                    expectedStartDate: expectedStartDate,
                                    startDate: nil,
                                    completed: false,
                                    completedAt: nil,
                                    expectedDeadline: expectedDeadline,
                                    taskStatus: .notStarted,
                                    isOnCreation: true
                                    )
        taskVideoList.currentState = NotStartedTaskVideoListState(taskVideoList: taskVideoList)
        return taskVideoList
    }
    
    static func createInProgressVideoList(listName: String, videosCount: Int, numVideosWatched: Int,
                                     title: String, progress: Int, expectedStartDate: Date?, startDate: Date?, expectedDeadline: Date?, taskStatus: TaskStatus) throws -> TaskVideoList {
        try TaskVideoList.validateInputsForInProgressTaskVideoList(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: progress, numVideosWatched: numVideosWatched, videosCount: videosCount)
        let taskVideoList = try TaskVideoList(listName: listName,
                                    videosCount: videosCount,
                                    numVideosWatched: numVideosWatched,
                                    title: title,
                                    progress: progress,
                                    expectedStartDate: expectedStartDate,
                                    startDate: startDate,
                                    completed: false,
                                    completedAt: nil,
                                    expectedDeadline: expectedDeadline,
                                    taskStatus: .inProgress,
                                    isOnCreation: true
                                    )
        taskVideoList.currentState = InProgressTaskVideoListState(taskVideoList: taskVideoList)
        return taskVideoList
    }
    
    static func createCompletedVideoList(listName: String, videosCount: Int, numVideosWatched: Int,
                                    title: String,
                                    expectedStartDate: Date?,
                                    startDate: Date?,
                                    completedAt: Date,
                                    expectedDeadline: Date?
    ) throws -> TaskVideoList {
        try TaskVideoList.validateInputsForCompletedTaskVideoList(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: 100, numVideosWatched: numVideosWatched, videosCount: videosCount, completed: true, completedAt: completedAt)
        let taskVideoList = try TaskVideoList(listName: listName,
                                    videosCount: videosCount,
                                    numVideosWatched: numVideosWatched,
                                    title: title,
                                    progress: 100,
                                    expectedStartDate: expectedStartDate,
                                    startDate: startDate,
                                    completed: true,
                                    completedAt: completedAt,
                                    expectedDeadline: expectedDeadline,
                                    taskStatus: .completed,
                                    isOnCreation: true
                                    )
        taskVideoList.currentState = CompletedTaskVideoListState(taskVideoList: taskVideoList)
        return taskVideoList
    }
    
    
    // MARK: - State transition methods
    func _transitionToState(_ status: TaskStatus) {
        super.transitionToState(status)
        switch status {
        case .notStarted:
            currentState = NotStartedTaskVideoListState(taskVideoList: self)
        case .inProgress:
            currentState = InProgressTaskVideoListState(taskVideoList: self)
        case .completed:
            currentState = CompletedTaskVideoListState(taskVideoList: self)
        }
    }
    
    // MARK: - Json Extractor
    override func getJson() -> String {
        let dateFormatter = ISO8601DateFormatter()
        //Any mean any value basic values(int, dboule..) or class instances.
        let jsonDict: [String: Any?] = [
            "id": id.uuidString,
            "type": "\(type)",
            "title": title,
            "progress": progress,
            "expectedStartDate": expectedStartDate.map { dateFormatter.string(from: $0) },
            "startDate": startDate.map { dateFormatter.string(from: $0) },
            "completed": completed,
            "completedAt": completedAt.map { dateFormatter.string(from: $0) },
            "expectedDeadline": expectedDeadline.map { dateFormatter.string(from: $0) },
            "taskStatus": "\(taskStatus)",
            "listName": listName,
            "videosCount": videosCount,
            "numVideosWatched": numVideosWatched
        ]

        // the Any? could hold nil, but json Serializer can't understand nil
        // if value is not nil, use value as it is
        // if value is nil replace it with NSNull object
        // NSNull() is how Swift/Objective-C represents null in JSON.
        let sanitizedDict = jsonDict.mapValues { $0 ?? NSNull() }

        do {
            // options: [.prettyPrinted]: This tells Swift to format the JSON output with indentation and line breaks
            let data = try JSONSerialization.data(withJSONObject: sanitizedDict, options: [.prettyPrinted])
            return String(data: data, encoding: .utf8) ?? "{}"
        } catch {
            return "{}"
        }
    }
    
    // MARK: public methods delegating to state
    func setNumVideosWatched(_ numVideosWatched: Int) throws {
        try currentStateCasted.setNumVideosWatched(numVideosWatched)
    }
    
    func increaseNumVideosWatchedBy(_ numVideosWatched: Int) throws {
        try currentStateCasted.increaseNumVideosWatchedBy(numVideosWatched)
    }
    
    // MARK:  internal methods
    func _setNumVideosWatched(_ numVideosWatched: Int) {
        self.numVideosWatched = numVideosWatched
        markAsChanged()
    }
    
    func _increaseNumVideosWatchedBy(_ numVideosWatched: Int) {
        self.numVideosWatched += numVideosWatched
        markAsChanged()
    }
    
    // MARK: - validators
    static func validateInputsForNotStartedTaskVideoList(listName: String, videosCount: Int, numVideosWatched: Int,
                                                    expectedStartDate: Date?, expectedDeadline: Date?,
                                                    isOnCreation: Bool) throws {
        try TaskObject.validateInputsForNotStartedTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, isOnCreation: isOnCreation)
        try TaskVideoList.validateVideoListInputs(listName: listName, videosCount: videosCount, numVideosWatched: numVideosWatched)
        if numVideosWatched > 0 {
            throw TaskVideoListError.videosWatchedIsGreaterThanZeroWhileNotStartedTaskVideoList
        }
    }
    
    static func validateVideoListInputs(listName: String, videosCount: Int, numVideosWatched: Int) throws {
        if listName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw TaskVideoListError.titleCannotBeEmpty
        } else if videosCount <= 0 {
            throw TaskVideoListError.videosCountLessThanOrEqualToZero
        } else if numVideosWatched < 0 {
            throw TaskVideoListError.videosWatchedLessThanZero
        } else if numVideosWatched > videosCount {
            throw TaskVideoListError.videosWatchedGreaterThanVideosCount
        }
    }
    
    static func validateInputsForInProgressTaskVideoList(expectedStartDate: Date?, expectedDeadline: Date?, startDate: Date?, progress: Int, numVideosWatched: Int, videosCount: Int) throws {
        
        try TaskObject.validateInputsForInProgressTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: progress)
        
        guard numVideosWatched >= 0 else {
            throw TaskVideoListError.videosWatchedLessThanZero
        }
        guard numVideosWatched < videosCount else {
            throw TaskVideoListError.videosWatchedGreaterThanVideosCount
        }
    }
    
    static func validateInputsForCompletedTaskVideoList(expectedStartDate: Date?, expectedDeadline: Date?, startDate: Date?, progress: Int, numVideosWatched: Int, videosCount: Int, completed: Bool, completedAt: Date) throws {
        
        try TaskObject.validateInputsForCompletedTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, completed: completed, completedAt: completedAt, progress: progress)
        
        guard numVideosWatched >= 0 else {
            throw TaskVideoListError.videosWatchedLessThanZero
        }
        guard numVideosWatched == videosCount else {
            throw TaskVideoListError.videosWatchedNotEqualToVideosCount
        }
    }
    
    // MARK: - validators for attributes
    func validateNumVideosWatched(_ numVideosWatched: Int) throws {
        if numVideosWatched < 0 {
            throw TaskVideoListError.videosWatchedLessThanZero
        } else if numVideosWatched > videosCount {
            throw TaskVideoListError.videosWatchedGreaterThanVideosCount
        }
    }
}
