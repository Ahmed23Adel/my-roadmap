//
//  TaskArticle.swift
//  myRoadmap
//
//  Created by ahmed on 19/05/2025.
//


import Foundation

final class TaskArticle: TaskObject{
    
    // MARK: - TaskArticle properties
    private(set) var articleName: String{
        didSet{
            super.markAsChanged()
        }
    }
    private(set) var linkToArticle: String{
        didSet{
            super.markAsChanged()
        }
    }
    
    // MARK: State properties
    var currentStateCasted: TaskArticleState {
        if let notStartedState = currentState as? NotStartedTaskArticleState {
            return notStartedState
        } else if let inProgressState = currentState as? InProgressTaskArticleState {
            return inProgressState
        } else {
            return currentState as! CompletedTaskArticleState
        }
    }
    
    
    // MARK: - Initialization
    private init(articleName: String, linkToArticle: String,
                 title: String, progress: Int, expectedStartDate: Date?,
                 startDate: Date?, completed: Bool, completedAt: Date?,
                 expectedDeadline: Date?, taskStatus: TaskStatus, isOnCreation: Bool
    ) throws {
        self.articleName = articleName
        self.linkToArticle = linkToArticle
        
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
    static func createNotStartedArticle(articleName: String, linkToArticle: String,
                                        title: String, expectedStartDate: Date?, expectedDeadline: Date?, isOnCreation: Bool = true) throws -> TaskArticle {
        try TaskArticle.validateInputsForNotStartedTaskArticle(articleName: articleName, linkToArticle: linkToArticle, expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, isOnCreation: isOnCreation)
        let taskArticle = try TaskArticle(articleName: articleName,
                                          linkToArticle: linkToArticle,
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
        taskArticle.currentState = NotStartedTaskArticleState(taskArticle: taskArticle)
        return taskArticle
    }
    
    static func createInProgressArticle(articleName: String, linkToArticle: String,
                                        title: String, progress: Int, expectedStartDate: Date?, startDate: Date?, expectedDeadline: Date?, taskStatus: TaskStatus, isOnCreation: Bool = true) throws -> TaskArticle {
        try TaskArticle.validateInputsForInProgressTaskArticle(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: progress, articleName: articleName, linkToArticle: linkToArticle)
        let taskArticle = try TaskArticle(articleName: articleName,
                                          linkToArticle: linkToArticle,
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
        taskArticle.currentState = InProgressTaskArticleState(taskArticle: taskArticle)
        return taskArticle
    }
    
    static func createCompletedArticle(articleName: String, linkToArticle: String,
                                       title: String,
                                       expectedStartDate: Date?,
                                       startDate: Date?,
                                       completedAt: Date,
                                       expectedDeadline: Date?, isOnCreation: Bool = true
                                       
    ) throws -> TaskArticle {
        try TaskArticle.validateInputsForCompletedTaskArticle(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: 100, completed: true, completedAt: completedAt, articleName: articleName, linkToArticle: linkToArticle)
        let taskArticle = try TaskArticle(articleName: articleName,
                                          linkToArticle: linkToArticle,
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
        taskArticle.currentState = CompletedTaskArticleState(taskArticle: taskArticle)
        return taskArticle
    }
    
    // MARK: public methods delegating to state
    func setArticleName(_ articleName: String) throws{
        self.currentStateCasted.setArticleName(articleName)
    }
    
    func setLinkToArticle(_ linkToArticle: String) throws{
        self.currentStateCasted.setLinkToArticle(linkToArticle)
    }
    
    // MARK: internal methods
    func _setArticleName(_ articleName: String){
        self.articleName = articleName
    }
    
    func _setLinkToArticle(_ linkToArticle: String){
        self.linkToArticle = linkToArticle
    }
    
    // MARK: - State transition methods
    func _transitionToState(_ status: TaskStatus) {
        super.transitionToState(status)
        switch status {
        case .notStarted:
            currentState = NotStartedTaskArticleState(taskArticle: self)
        case .inProgress:
            currentState = InProgressTaskArticleState(taskArticle: self)
        case .completed:
            currentState = CompletedTaskArticleState(taskArticle: self)
        }
    }
    
    // MARK: - Json Extractor
    override func getJson() -> String {
        let dateFormatter = ISO8601DateFormatter()
        //Any mean any value basic values(int, dboule..) or class instances.
        let jsonDict: [String: Any?] = [
            "id": id.uuidString,
            "type": "article",
            "title": title,
            "progress": progress,
            "expectedStartDate": expectedStartDate.map { dateFormatter.string(from: $0) },
            "startDate": startDate.map { dateFormatter.string(from: $0) },
            "completed": completed,
            "completedAt": completedAt.map { dateFormatter.string(from: $0) },
            "expectedDeadline": expectedDeadline.map { dateFormatter.string(from: $0) },
            "taskStatus": "\(taskStatus)",
            "articleName": articleName,
            "linkToArticle": linkToArticle
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
    
    // MARK: - validators
    static func validateInputsForNotStartedTaskArticle(articleName: String, linkToArticle: String,
                                                    expectedStartDate: Date?, expectedDeadline: Date?,
                                                    isOnCreation: Bool) throws{
        try TaskObject.validateInputsForNotStartedTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, isOnCreation: isOnCreation)
        try TaskArticle.validateArticleInputs(articleName: articleName, linkToArticle: linkToArticle)
    }
    
    
    static func validateArticleInputs(articleName: String, linkToArticle: String) throws{
        if articleName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw TaskArticleError.articleNameCannotBeEmpty
        } else if linkToArticle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw TaskArticleError.linkToArticleCannotBeEmpty
        }
    }
    
    static func validateInputsForInProgressTaskArticle(expectedStartDate: Date?, expectedDeadline: Date?, startDate: Date?, progress: Int, articleName: String, linkToArticle: String) throws {
        
        try TaskObject.validateInputsForInProgressTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, progress: progress)
        try TaskArticle.validateArticleInputs(articleName: articleName, linkToArticle: linkToArticle)
        
    }
    
    
    static func validateInputsForCompletedTaskArticle(expectedStartDate: Date?, expectedDeadline: Date?, startDate: Date?, progress: Int, completed: Bool, completedAt: Date, articleName: String, linkToArticle: String) throws {
        
        try TaskObject.validateInputsForCompletedTask(expectedStartDate: expectedStartDate, expectedDeadline: expectedDeadline, startDate: startDate, completed: completed, completedAt: completedAt, progress: progress)
        try TaskArticle.validateArticleInputs(articleName: articleName, linkToArticle: linkToArticle)
        
    }
}
