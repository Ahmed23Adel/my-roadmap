//
//  CompletedTaskObjectState.swift
//  myRoadmap
//
//  Created by ahmed on 16/05/2025.
//

import Foundation

class CompletedTaskObjectState: TaskObjectState{
    weak var task: TaskObject?
        
    required init(task: TaskObject) {
        self.task = task
    }
    
    func setProgress(_ progress: Int) throws {
        // Cannot change progress for completed tasks
        throw ProgressError.cannotSetProgressInCompletedState
    }
    
    func setTitle(_ title: String) throws {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw TaskValidationError.emptyTitle
        }
        task?._setTitle(title)
    }
    
    func setExpectedStartDate(_ date: Date?) throws {
        if let expectedEnd = task?.expectedDeadline, let start = date, start > expectedEnd {
            throw TaskValidationError.invalidExpectedTimeRange
        }
        task?._setExpectedStartDate(date)
    }
    
    func setExpectedDeadline(_ date: Date?) throws {
        if let expectedStart = task?.expectedStartDate, let end = date, end < expectedStart {
            throw TaskValidationError.expectedDeadlineBeforeStart
        }
        task?._setExpectedDeadline(date)
    }
    
    func startTask() throws {
        throw TaskValidationError.cannotStartTaskInCompletedState
    }
    
    func completeTask() throws {
        throw TaskValidationError.cannotComplteACompletedTask
    }
    
    func validateState() throws {
        guard let startDate = task?.startDate else {
            throw TaskValidationError.startDateMissing
        }
        
        guard let completedAt = task?.completedAt else {
            throw TaskValidationError.completedAtMissing
        }
        
        if startDate > Date() {
            throw TaskValidationError.startDateInFuture
        }
        
        if completedAt < startDate {
            throw TaskValidationError.completedBeforeStart
        }
        
        if let expectedStartDate = task?.expectedStartDate,
           let expectedDeadline = task?.expectedDeadline,
           expectedStartDate > expectedDeadline {
            throw TaskValidationError.invalidExpectedTimeRange
        }
    }
    
}
