//
//  TaskYoutubePlaylist.swift
//  myRoadmap
//
//  Created by ahmed on 18/05/2025.
//

import Foundation

final class TaskYoutubePlaylist: TaskObject {
    
    // MARK: - YoutubePlaylist properties
    private(set) var playlistName: String {
        didSet {
            super.markAsChanged()
        }
    }
    
    private(set) var videoCount: Int {
        didSet {
            super.markAsChanged()
        }
    }
    
    private(set) var numVideosWatched: Int {
        didSet {
            super.markAsChanged()
        }
    }
    
    private(set) var linkToYoutube: String {
        didSet {
            super.markAsChanged()
        }
    }
    
    // MARK: State properties
    var currentStateCasted: YoutubePlaylistState {
        if let notStartedState = currentState as? NotStartedTaskYoutubePlaylistState {
            return notStartedState
        } else if let inProgressState = currentState as? InProgressTaskYoutubePlaylistState {
            return inProgressState
        } else {
            return currentState as! CompletedTaskYoutubePlaylistState
        }
    }
    
    // MARK: - Initialization
    private init(playlistName: String, videoCount: Int, numVideosWatched: Int, linkToYoutube: String,
                 title: String, progress: Int, expectedStartDate: Date?,
                 startDate: Date?, completed: Bool, completedAt: Date?,
                 expectedDeadline: Date?, taskStatus: TaskStatus, isOnCreation: Bool
    ) throws {
        self.playlistName = playlistName
        self.videoCount = videoCount
        self.numVideosWatched = numVideosWatched
        self.linkToYoutube = linkToYoutube
        
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
    static func createNotStartedYoutubePlaylist(playlistName: String, videoCount: Int, linkToYoutube: String,
                                              title: String, expectedStartDate: Date?, expectedDeadline: Date?) throws -> TaskYoutubePlaylist {
        try TaskYoutubePlaylist.validateInputsForNotStartedYoutubePlaylist(playlistName: playlistName, videoCount: videoCount, numVideosWatched: 0, linkToYoutube: linkToYoutube, expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, isOnCreation: true)
        
        let youtubePlaylist = try TaskYoutubePlaylist(playlistName: playlistName,
                                                videoCount: videoCount,
                                                numVideosWatched: 0,
                                                linkToYoutube: linkToYoutube,
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
        youtubePlaylist.currentState = NotStartedTaskYoutubePlaylistState(youtubePlaylist: youtubePlaylist)
        return youtubePlaylist
    }
    
    static func createInProgressYoutubePlaylist(playlistName: String, videoCount: Int, numVideosWatched: Int, linkToYoutube: String,
                                              title: String, progress: Int, expectedStartDate: Date?, startDate: Date?, expectedDeadline: Date?, taskStatus: TaskStatus) throws -> TaskYoutubePlaylist {
        try TaskYoutubePlaylist.validateInputsForInProgressYoutubePlaylist(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: progress, numVideosWatched: numVideosWatched, videoCount: videoCount, linkToYoutube: linkToYoutube)
        
        let youtubePlaylist = try TaskYoutubePlaylist(playlistName: playlistName,
                                                videoCount: videoCount,
                                                numVideosWatched: numVideosWatched,
                                                linkToYoutube: linkToYoutube,
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
        youtubePlaylist.currentState = InProgressTaskYoutubePlaylistState(youtubePlaylist: youtubePlaylist)
        return youtubePlaylist
    }
    
    static func createCompletedYoutubePlaylist(playlistName: String, videoCount: Int, linkToYoutube: String,
                                             title: String,
                                             expectedStartDate: Date?,
                                             startDate: Date?,
                                             completedAt: Date,
                                             expectedDeadline: Date?
    ) throws -> TaskYoutubePlaylist {
        try TaskYoutubePlaylist.validateInputsForCompletedYoutubePlaylist(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: 100, numVideosWatched: videoCount, videoCount: videoCount, linkToYoutube: linkToYoutube, completed: true, completedAt: completedAt)
        
        let youtubePlaylist = try TaskYoutubePlaylist(playlistName: playlistName,
                                                videoCount: videoCount,
                                                numVideosWatched: videoCount,
                                                linkToYoutube: linkToYoutube,
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
        youtubePlaylist.currentState = CompletedTaskYoutubePlaylistState(youtubePlaylist: youtubePlaylist)
        return youtubePlaylist
    }
    
    // MARK: - State transition methods
    func _transitionToState(_ status: TaskStatus) {
        super.transitionToState(status)
        switch status {
        case .notStarted:
            currentState = NotStartedTaskYoutubePlaylistState(youtubePlaylist: self)
        case .inProgress:
            currentState = InProgressTaskYoutubePlaylistState(youtubePlaylist: self)
        case .completed:
            currentState = CompletedTaskYoutubePlaylistState(youtubePlaylist: self)
        }
    }
    
    // MARK: - Json Extractor
    override func getJson() -> String {
        let dateFormatter = ISO8601DateFormatter()
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
            "playlistName": playlistName,
            "videoCount": videoCount,
            "numVideosWatched": numVideosWatched,
            "linkToYoutube": linkToYoutube
        ]
        
        let sanitizedDict = jsonDict.mapValues { $0 ?? NSNull() }
        
        do {
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
    
    // MARK: internal methods
    func _setNumVideosWatched(_ numVideosWatched: Int) {
        self.numVideosWatched = numVideosWatched
        markAsChanged()
    }
    
    func _increaseNumVideosWatchedBy(_ numVideosWatched: Int) {
        self.numVideosWatched += numVideosWatched
        markAsChanged()
    }
    
    // MARK: - validators
    static func validateInputsForNotStartedYoutubePlaylist(playlistName: String, videoCount: Int, numVideosWatched: Int,
                                                         linkToYoutube: String, expectedStartDate: Date?, expectedDeadline: Date?,
                                                         isOnCreation: Bool) throws {
        try TaskObject.validateInputsForNotStartedTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, isOnCreation: isOnCreation)
        try TaskYoutubePlaylist.validateYoutubePlaylistInputs(playlistName: playlistName, videoCount: videoCount, numVideosWatched: numVideosWatched, linkToYoutube: linkToYoutube)
        if numVideosWatched > 0 {
            throw TaskYoutubePlaylistError.videosWatchedIsGreaterThanZeroWhileNotStartedYoutubePlaylist
            
        } 
    }
    
    static func validateYoutubePlaylistInputs(playlistName: String, videoCount: Int, numVideosWatched: Int, linkToYoutube: String) throws {
        if playlistName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw TaskYoutubePlaylistError.playListNameCannotBeEmpty
        } else if videoCount <= 0 {
            throw TaskYoutubePlaylistError.videoCountLessThanOrEqualToZero
        } else if numVideosWatched < 0 {
            throw TaskYoutubePlaylistError.videosWatchedLessThanZero
        } else if numVideosWatched > videoCount {
            throw TaskYoutubePlaylistError.videosWatchedGreaterThanVideoCount
        }
        
        // Basic URL validation
        if !linkToYoutube.lowercased().contains("youtube.com") && !linkToYoutube.lowercased().contains("youtu.be") {
            throw TaskYoutubePlaylistError.invalidYoutubeUrl
        }
    }
    
    static func validateInputsForInProgressYoutubePlaylist(expectedStartDate: Date?, expectedDeadline: Date?, startDate: Date?, progress: Int, numVideosWatched: Int, videoCount: Int, linkToYoutube: String) throws {
        try TaskObject.validateInputsForInProgressTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: progress)
        guard numVideosWatched >= 0 else {
            throw TaskYoutubePlaylistError.videosWatchedLessThanZero
        }
        guard numVideosWatched < videoCount else {
            throw TaskYoutubePlaylistError.videosWatchedGreaterThanVideoCount
        }
        // Basic URL validation
        if !linkToYoutube.lowercased().contains("youtube.com") && !linkToYoutube.lowercased().contains("youtu.be") {
            throw TaskYoutubePlaylistError.invalidYoutubeUrl
        }
        if numVideosWatched >= videoCount {
            throw TaskYoutubePlaylistError.numVideosWatchedCannotBeEqualOrGreaterThanVideoCountInProgressState
        }
    }
    
    static func validateInputsForCompletedYoutubePlaylist(expectedStartDate: Date?, expectedDeadline: Date?, startDate: Date?, progress: Int, numVideosWatched: Int, videoCount: Int, linkToYoutube: String, completed: Bool, completedAt: Date) throws {
        try TaskObject.validateInputsForCompletedTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, completed: completed, completedAt: completedAt, progress: progress)
        
        guard numVideosWatched >= 0 else {
            throw TaskYoutubePlaylistError.videosWatchedLessThanZero
        }
        guard numVideosWatched == videoCount else {
            throw TaskYoutubePlaylistError.videosWatchedGreaterThanVideoCount
        }
        
        // Basic URL validation
        if !linkToYoutube.lowercased().contains("youtube.com") && !linkToYoutube.lowercased().contains("youtu.be") {
            throw TaskYoutubePlaylistError.invalidYoutubeUrl
        }
    }
    
    // MARK: - validators for attributes
    func validateNumVideosWatched(_ numVideosWatched: Int) throws {
        if numVideosWatched < 0 {
            throw TaskYoutubePlaylistError.videosWatchedLessThanZero
        } else if numVideosWatched > videoCount {
            throw TaskYoutubePlaylistError.videosWatchedGreaterThanVideoCount
        }
    }
}
