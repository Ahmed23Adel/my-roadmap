//
//  TaskBook.swift
//  myRoadmap
//
//  Created by ahmed on 14/05/2025.
//

import Foundation

final class TaskBook: TaskObject{
    
    // MARK: - TaskBook properties
    private(set) var bookName: String{
        didSet{
            super.markAsChanged()
        }
    }
    private(set) var numPagesInBook: Int{
        didSet{
            super.markAsChanged()
        }
    }
    
    private(set) var numPagesRead: Int{
        didSet{
            super.markAsChanged()
        }
    }
    
    // MARK: State properties
    var currentStateCasted: TaskBookState {
        if let notStartedState = currentState as? NotStartedTaskBookState {
            return notStartedState
        } else if let inProgressState = currentState as? InProgressTaskBookState {
            return inProgressState
        } else {
            return currentState as! CompletedTaskBookState
        }
    }
    
    
    // MARK: - Initialization
    private init(bookName: String, numPagesInBook: Int, numPagesRead: Int,
         title: String, progress: Int, expectedStartDate: Date?,
         startDate: Date?, completed: Bool, completedAt: Date?,
                 expectedDeadline: Date?, taskStatus: TaskStatus, isOnCreation: Bool
    ) throws {
        self.bookName = bookName
        self.numPagesInBook = numPagesInBook
        self.numPagesRead = numPagesRead
        
        super.init(title: title,
                   progress: progress,
                   expectedStartDate: expectedStartDate,
                   startDate: startDate,
                   completed: completed,
                   completedAt: completedAt,
                   expectedDeadline: expectedDeadline,
                   taskStatus: taskStatus
        )
        
        if isOnCreation{
            super.initChangeStatusOnCreationofBook()
        }
        
    }
    // MARK: - Factory methods
    static func createNotStartedBook(bookName: String, numPagesInBook: Int,
                                     title: String, expectedStartDate: Date?, expectedDeadline: Date?) throws -> TaskBook {
        try TaskBook.validateInputsForNotStartedTaskBook(bookName: bookName, numPagesInBook: numPagesInBook, numPagesRead: 0, expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, isOnCreation: true)
        let taskBook = try TaskBook(bookName: bookName,
                                    numPagesInBook: numPagesInBook,
                                    numPagesRead: 0,
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
        taskBook.currentState = NotStartedTaskBookState(taskBook: taskBook)
        return taskBook
    }
    
    static func createInProgressBook(bookName: String, numPagesInBook: Int, numPagesRead: Int,
                                     title: String, progress: Int, expectedStartDate: Date?, startDate: Date?, expectedDeadline: Date?, taskStatus: TaskStatus) throws -> TaskBook {
        try TaskBook.validateInputsForInProgressTaskBook(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: progress, numPagesRead: numPagesRead, numPagesInBook: numPagesInBook)
        let taskBook = try TaskBook(bookName: bookName,
                                    numPagesInBook: numPagesInBook,
                                    numPagesRead: numPagesRead,
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
        taskBook.currentState = InProgressTaskBookState(taskBook: taskBook)
        return taskBook
    }
    
    static func createCompletedBook(bookName: String, numPagesInBook: Int, numPagesRead: Int,
                                    title: String,
                                    expectedStartDate: Date?,
                                    startDate: Date?,
                                    completedAt: Date,
                                    expectedDeadline: Date?
    ) throws -> TaskBook {
        try TaskBook.validateInputsForCompletedTaskBook(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: 100, numPagesRead: 100, numPagesInBook: 100, completed: true, completedAt: completedAt)
        let taskBook = try TaskBook(bookName: bookName,
                                    numPagesInBook: numPagesInBook,
                                    numPagesRead: numPagesRead,
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
        taskBook.currentState = CompletedTaskBookState(taskBook: taskBook)
        return taskBook
    }
    
    
    // MARK: - State transition methods
    func _transitionToState(_ status: TaskStatus) {
        super.transitionToState(status)
        switch status {
        case .notStarted:
            currentState = NotStartedTaskBookState(taskBook: self)
        case .inProgress:
            currentState = InProgressTaskBookState(taskBook: self)
        case .completed:
            currentState = CompletedTaskBookState(taskBook: self)
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
            "bookName": bookName, // this return case name
            "numPagesInBook": numPagesInBook,
            "numPagesRead": numPagesRead
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
    func setNumPagesRead(_ numPagesRead: Int) throws {
        try currentStateCasted.setNumPagesRead(numPagesRead)
    }
    
    func increaseNumPagesReadBy(_ numPagesRead: Int) throws {
        try currentStateCasted.increaseNumPagesReadBy(numPagesRead)
    }
    
    
    
    // MARK:  internal methods
    func _setNumPagesRead(_ numPagesRead: Int) {
        self.numPagesRead = numPagesRead
        markAsChanged()
    }
    
    
    func _increaseNumPagesReadBy(_ numPagesRead: Int) {
        self.numPagesRead += numPagesRead
        markAsChanged()
    }
    
    
    // MARK: - validators
    static func validateInputsForNotStartedTaskBook(bookName: String, numPagesInBook: Int, numPagesRead: Int,
                                                    expectedStartDate: Date?, expectedDeadline: Date?,
                                                    isOnCreation: Bool) throws{
        try TaskObject.validateInputsForNotStartedTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, isOnCreation: isOnCreation)
        try TaskBook.validateBookInputs(bookName: bookName, numPagesInBook: numPagesInBook, numPagesRead: numPagesRead)
        if numPagesRead > 0 {
            throw TaskBookError.pagesReadIsGreaaterThanZeroWhileNotStartedTaskBook
        }
    }
    
    
    static func validateBookInputs(bookName: String, numPagesInBook: Int, numPagesRead: Int) throws{
        if bookName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw TaskBookError.titleCannotBeEmpty
        } else if numPagesInBook <= 0 {
            throw TaskBookError.numPagesInBookLessThanOrEqualToZero
        } else if numPagesRead < 0 {
            throw TaskBookError.pagesReadLessThanZero
        } else if numPagesRead > numPagesInBook {
            throw TaskBookError.pagesReadGreaterThanNumberOfPagesInBook
        }
    }
    
    static func validateInputsForInProgressTaskBook(expectedStartDate: Date?, expectedDeadline: Date?, startDate: Date?, progress: Int, numPagesRead: Int, numPagesInBook: Int) throws {
        
        try TaskObject.validateInputsForInProgressTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: progress)
        
        guard numPagesRead >= 0  else {
            throw TaskBookError.numPagesInBookLessThanOrEqualToZero
        }
        guard numPagesRead < numPagesInBook else{
            throw TaskBookError.pagesReadGreaterThanNumberOfPagesInBook
        }
        
    }
    
    
    static func validateInputsForCompletedTaskBook(expectedStartDate: Date?, expectedDeadline: Date?, startDate: Date?, progress: Int, numPagesRead: Int, numPagesInBook: Int, completed: Bool, completedAt: Date) throws {
        
        try TaskObject.validateInputsForCompletedTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, completed: completed, completedAt: completedAt, progress: progress)
        
        guard numPagesRead >= 0  else {
            throw TaskBookError.numPagesInBookLessThanOrEqualToZero
        }
        guard numPagesRead == numPagesInBook else{
            throw TaskBookError.pagesReadGreaterThanNumberOfPagesInBook
        }
    }
    
    
    // MARK: - validators for attributes
    func validateNumPagesRead(_ numPagesRead: Int) throws{
        // users can go backward in reading if some mistakes happen
        if numPagesRead < 0 {
            throw TaskBookError.numPagesInBookLessThanZero
        } else if numPagesRead > numPagesInBook {
            throw TaskBookError.pagesReadGreaterThanNumberOfPagesInBook
        } 
    }
}
