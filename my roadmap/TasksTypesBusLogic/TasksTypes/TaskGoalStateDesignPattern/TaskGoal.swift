//
//  TaskGoal.swift
//  myRoadmap
//
//  Created by ahmed on 20/05/2025.
//

import Foundation
final class TaskGoal: TaskObject {
    
    // MARK: - Goal properties
    private(set) var details: String {
        didSet {
            super.markAsChanged()
        }
    }
    
    private(set) var imageLink: String? {
        didSet {
            super.markAsChanged()
        }
    }
    
    // MARK: State properties
    var currentStateCasted: GoalState {
        if let notStartedState = currentState as? NotStartedTaskGoalState {
            return notStartedState
        } else if let inProgressState = currentState as? InProgressTaskGoalState {
            return inProgressState
        } else {
            return currentState as! CompletedTaskGoalState
        }
    }
    
    // MARK: - Initialization
    private init(details: String, imageLink: String?,
                 title: String, progress: Int, expectedStartDate: Date?,
                 startDate: Date?, completed: Bool, completedAt: Date?,
                 expectedDeadline: Date?, taskStatus: TaskStatus, isOnCreation: Bool
    ) throws {
        self.details = details
        self.imageLink = imageLink
        
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
    static func createNotStartedGoal(details: String, imageLink: String?,
                                     title: String, expectedStartDate: Date?, expectedDeadline: Date?, isOnCreation: Bool = true) throws -> TaskGoal {
        try TaskGoal.validateInputsForNotStartedGoal(details: details, imageLink: imageLink, expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, isOnCreation: isOnCreation)
        
        let goal = try TaskGoal(details: details,
                                imageLink: imageLink,
                                title: title,
                                progress: 0,
                                expectedStartDate: expectedStartDate,
                                startDate: nil,
                                completed: false,
                                completedAt: nil,
                                expectedDeadline: expectedDeadline,
                                taskStatus: .notStarted,
                                isOnCreation: isOnCreation
        )
        goal.currentState = NotStartedTaskGoalState(taskGoal: goal)
        return goal
    }
    
    static func createInProgressGoal(details: String, imageLink: String?,
                                     title: String, progress: Int, expectedStartDate: Date?, startDate: Date?,
                                     expectedDeadline: Date?, taskStatus: TaskStatus, isOnCreation: Bool = true) throws -> TaskGoal {
        try TaskGoal.validateInputsForInProgressGoal(details: details, imageLink: imageLink, expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: progress)
        
        let goal = try TaskGoal(details: details,
                                imageLink: imageLink,
                                title: title,
                                progress: progress,
                                expectedStartDate: expectedStartDate,
                                startDate: startDate,
                                completed: false,
                                completedAt: nil,
                                expectedDeadline: expectedDeadline,
                                taskStatus: .inProgress,
                                isOnCreation: isOnCreation
        )
        goal.currentState = InProgressTaskGoalState(taskGoal: goal)
        return goal
    }
    
    static func createCompletedGoal(details: String, imageLink: String?,
                                    title: String,
                                    expectedStartDate: Date?,
                                    startDate: Date?,
                                    completedAt: Date,
                                    expectedDeadline: Date?, isOnCreation: Bool = true
    ) throws -> TaskGoal {
        try TaskGoal.validateInputsForCompletedGoal(details: details, imageLink: imageLink, expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: 100, completed: true, completedAt: completedAt)
        
        let goal = try TaskGoal(details: details,
                                imageLink: imageLink,
                                title: title,
                                progress: 100,
                                expectedStartDate: expectedStartDate,
                                startDate: startDate,
                                completed: true,
                                completedAt: completedAt,
                                expectedDeadline: expectedDeadline,
                                taskStatus: .completed,
                                isOnCreation: isOnCreation
        )
        goal.currentState = CompletedTaskGoalState(taskGoal: goal)
        return goal
    }
    
    // MARK: - State transition methods
    func _transitionToState(_ status: TaskStatus) {
        super.transitionToState(status)
        switch status {
        case .notStarted:
            currentState = NotStartedTaskGoalState(taskGoal: self)
        case .inProgress:
            currentState = InProgressTaskGoalState(taskGoal: self)
        case .completed:
            currentState = CompletedTaskGoalState(taskGoal: self)
        }
    }
    
    // MARK: - Json Extractor
    override func getJson() -> String {
        let dateFormatter = ISO8601DateFormatter()
        let jsonDict: [String: Any?] = [
            "id": id.uuidString,
            "type": "goal",
            "title": title,
            "progress": progress,
            "expectedStartDate": expectedStartDate.map { dateFormatter.string(from: $0) },
            "startDate": startDate.map { dateFormatter.string(from: $0) },
            "completed": completed,
            "completedAt": completedAt.map { dateFormatter.string(from: $0) },
            "expectedDeadline": expectedDeadline.map { dateFormatter.string(from: $0) },
            "taskStatus": "\(taskStatus)",
            "details": details,
            "imageLink": imageLink
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
    func setDetails(_ details: String) throws {
        try currentStateCasted.setDetails(details)
    }
    
    func setImageLink(_ imageLink: String?) throws {
        try currentStateCasted.setImageLink(imageLink)
    }
    
    // MARK: internal methods
    func _setDetails(_ details: String) {
        self.details = details
        markAsChanged()
    }
    
    func _setImageLink(_ imageLink: String?) {
        self.imageLink = imageLink
        markAsChanged()
    }
    
    // MARK: - validators
    static func validateInputsForNotStartedGoal(details: String, imageLink: String?,
                                               expectedStartDate: Date?, expectedDeadline: Date?,
                                               isOnCreation: Bool) throws {
        try TaskObject.validateInputsForNotStartedTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, isOnCreation: isOnCreation)
        try TaskGoal.validateGoalInputs(details: details, imageLink: imageLink)
    }
    
    static func validateGoalInputs(details: String, imageLink: String?) throws {
        // Details could be empty, title is enough for this task
        
        // Validate imageLink if provided
        if let imageLink = imageLink, !imageLink.isEmpty {
            // Basic URL validation - could be expanded based on requirements
            if !imageLink.contains("http://") && !imageLink.contains("https://") {
                throw TaskGoalError.invalidImageUrl
            }
        }
    }
    
    static func validateImageLink(_ imageLink: String?) throws {
        if let imageLink = imageLink, !imageLink.isEmpty {
            if !imageLink.contains("http://") && !imageLink.contains("https://") {
                throw TaskGoalError.invalidImageUrl
            }
        }
    }
    
    static func validateInputsForInProgressGoal(details: String, imageLink: String?,
                                              expectedStartDate: Date?, expectedDeadline: Date?,
                                              startDate: Date?, progress: Int) throws {
        try TaskObject.validateInputsForInProgressTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: progress)
        try TaskGoal.validateGoalInputs(details: details, imageLink: imageLink)
    }
    
    static func validateInputsForCompletedGoal(details: String, imageLink: String?,
                                             expectedStartDate: Date?, expectedDeadline: Date?,
                                             startDate: Date?, progress: Int,
                                             completed: Bool, completedAt: Date) throws {
        try TaskObject.validateInputsForCompletedTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, completed: completed, completedAt: completedAt, progress: progress)
        try TaskGoal.validateGoalInputs(details: details, imageLink: imageLink)
    }
}
