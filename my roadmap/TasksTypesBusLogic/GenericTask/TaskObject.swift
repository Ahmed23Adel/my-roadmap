//
//  Task.swift
//  myRoadmap
//
//  Created by ahmed on 14/05/2025.
//

import Foundation
import Combine

class TaskObject: GenericTask, StateLocalSyncTrackable, StateCloudSyncTrackable, Hashable {
    var posX: CGFloat
    var posY: CGFloat

    // MARK: - StateLocalSyncTrackable & StateCloudSyncTrackable properties
    var localIsChanged: Bool = false
    var localIsSynedWithFilesDirectory: Bool = true
    var cloudIsChanged: Bool = false
    var cloudIsSynedWithCloud: Bool = true
    
    // MARK: - GenericTask properties
    private(set) var id: UUID
    private(set) var type: StateType
    private(set) var title: String
    private(set) var progress: Int
    private(set) var expectedStartDate: Date?
    private(set) var startDate: Date?
    private(set) var completed: Bool
    private(set) var completedAt: Date?
    private(set) var expectedDeadline: Date?
    @Published private(set) var taskStatus: TaskStatus
    
    // MARK: - State property
    var currentState: TaskObjectState!
    
    // MARK: - Initialization
    
    init(title: String, progress: Int = 0, expectedStartDate: Date? = nil, startDate: Date? = nil,
         completed: Bool = false, completedAt: Date? = nil, expectedDeadline: Date? = nil,
         taskStatus: TaskStatus = .notStarted) {
        
        self.id = UUID()
        self.title = title
        self.type = .task
        self.progress = progress
        self.startDate = startDate
        self.completed = completed
        self.completedAt = completedAt
        self.expectedStartDate = expectedStartDate
        self.expectedDeadline = expectedDeadline
        self.taskStatus = taskStatus
        
        posX = 0
        posY = 0
        // Initialize state based on taskStatus
        switch taskStatus {
        case .notStarted:
            self.currentState = NotStartedTaskObjectState(task: self)
        case .inProgress:
            self.currentState = InProgressTaskObjectState(task: self)
        case .completed:
            self.currentState = CompletedTaskObjectState(task: self)
        }
        
        do {
            try self.currentState.validateState()
        } catch {
            fatalError("Invalid initial state: \(error)")
        }
        
        initChangeStatusOnCreationofBook()
    }
    
    // MARK: - State transition methods
    
    func transitionToState(_ status: TaskStatus) {
        switch status {
        case .notStarted:
            taskStatus = .notStarted
            currentState = NotStartedTaskObjectState(task: self)
        case .inProgress:
            taskStatus = .inProgress
            currentState = InProgressTaskObjectState(task: self)
        case .completed:
            taskStatus = .completed
            currentState = CompletedTaskObjectState(task: self)
        }
    }
    
    // MARK: - Public methods delegating to state
    
    func setProgress(_ progress: Int) throws {
        try currentState.setProgress(progress)
    }
    
    func setTitle(_ title: String) throws {
        try currentState.setTitle(title)
    }
    
    func setExpectedStartDate(_ date: Date?) throws {
        try currentState.setExpectedStartDate(date)
    }
    
    func setExpectedDeadline(_ date: Date?) throws {
        try currentState.setExpectedDeadline(date)
    }
    
    func startTask() throws {
        try currentState.startTask()
    }
    
    func completeTask() throws {
        try currentState.completeTask()
    }
    
    // MARK: - Internal methods for state to modify properties
    
    func _setTitle(_ title: String) {
        self.title = title
        markAsChanged()
    }
    
    func _setProgress(_ progress: Int) {
        self.progress = progress
        markAsChanged()
    }
    
    func _setExpectedStartDate(_ date: Date?) {
        self.expectedStartDate = date
        markAsChanged()
    }
    
    func _setStartDate(_ date: Date?) {
        self.startDate = date
        markAsChanged()
    }
    
    func _setCompleted(_ completed: Bool) {
        self.completed = completed
        markAsChanged()
    }
    
    func _setCompletedAt(_ date: Date?) {
        self.completedAt = date
        markAsChanged()
    }
    
    func _setExpectedDeadline(_ date: Date?) {
        self.expectedDeadline = date
        markAsChanged()
    }
    
    func _setTaskStatus(_ status: TaskStatus) {
        self.taskStatus = status
        markAsChanged()
    }
    
    // MARK: - Sync methods
    
    func markAsChanged() {
        localMarkAsChanged()
        cloudMarkAsChanged()
        localMarkAsNotSynedFilesDirectory()
        cloudMarkAsNotSynedWithCloud()
    }
    
    func localMarkAsChanged() {
        localIsChanged = true
    }
    
    func localMarkAsNotChanged() {
        localIsChanged = false
    }
    
    func localMarkAsSynedWithFilesDirectory() {
        localIsSynedWithFilesDirectory = true
    }
    
    func localMarkAsNotSynedFilesDirectory() {
        localIsSynedWithFilesDirectory = false
    }
    
    func cloudMarkAsChanged() {
        cloudIsChanged = true
    }
    
    func cloudMarkAsNotChanged() {
        cloudIsChanged = false
    }
    
    func cloudMarkAsSynedWithCloud() {
        cloudIsSynedWithCloud = true
    }
    
    func cloudMarkAsNotSynedWithCloud() {
        cloudIsSynedWithCloud = false
    }
    
    func initChangeStatusOnCreationofBook() {
        localIsChanged = true
        localIsSynedWithFilesDirectory = false
        cloudIsChanged = false
        cloudIsSynedWithCloud = false
    }
    
   
    // MARK: - Validators
    static func validateInputsForNotStartedTask(expectedStartDate: Date?, expectedDeadline: Date?, isOnCreation: Bool) throws{
        if let expectedStartDate = expectedStartDate,let expectedDeadline = expectedDeadline, expectedStartDate > expectedDeadline {
            throw TaskValidationError.invalidExpectedTimeRange
        }
        print("isOnCreation", isOnCreation)
        if isOnCreation , let expectedStartDate = expectedStartDate, expectedStartDate < Date() {
            throw TaskValidationError.expectedStartDateInPast
        }
    }
    
    static func validateInputsForInProgressTask(expectedStartDate: Date?, expectedDeadline: Date?, startDate: Date?, progress: Int) throws {
        // Check progress range
        guard progress >= 0 && progress < 100 else {
            throw TaskValidationError.invalidProgressForInProgressTask
        }
        // Start date must be non-nil and not in the future
        guard let startDate = startDate else {
            throw TaskValidationError.startDateMissing
        }
        if startDate > Date() {
            throw TaskValidationError.startDateInFuture
        }
        // Validate expectedStartDate and expectedDeadline range
        if let expectedStartDate = expectedStartDate,
           let expectedDeadline = expectedDeadline,
           expectedStartDate > expectedDeadline {
            throw TaskValidationError.invalidExpectedTimeRange
        }
    }
    
    static func validateInputsForCompletedTask(expectedStartDate: Date?, expectedDeadline: Date?, startDate: Date?, completed: Bool, completedAt: Date?, progress: Int) throws {
        
        guard completed else {
            throw TaskValidationError.taskNotMarkedAsCompleted
        }

        guard progress == 100 else {
            throw TaskValidationError.invalidProgressForCompletedTask
        }

        guard let startDate = startDate else {
            throw TaskValidationError.startDateMissing
        }

        guard let completedAt = completedAt else {
            throw TaskValidationError.completedAtMissing
        }

        if completedAt < startDate {
            throw TaskValidationError.completedAtBeforeStartDate
        }

        
    }
    
    // MARK: Drawable
    func calcWidth() -> CGFloat {
        return DrawableConstants.width
    }
    
    func calcHeight() -> CGFloat {
        return DrawableConstants.height
    }
    
    func calcMarginedWidth() -> CGFloat {
        return DrawableConstants.width + DrawableConstants.margin
    }
    
    func calcMarginedHeight() -> CGFloat {
        return DrawableConstants.height + DrawableConstants.margin
    }

    
    // MARK: JsonExtractor
    // must be implemented in subclases
    func getJson() -> String {
        return ""
    }
    
    // MARK: - Hashable Conformance
        
    // Equatable conformance (required by Hashable)
    static func == (lhs: TaskObject, rhs: TaskObject) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
