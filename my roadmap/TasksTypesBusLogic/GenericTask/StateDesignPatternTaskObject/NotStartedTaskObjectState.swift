//
//  NotStartedTaskObjectState.swift
//  myRoadmap
//
//  Created by ahmed on 16/05/2025.
//

import Foundation

class NotStartedTaskObjectState: TaskObjectState{
    weak var task: TaskObject?
        
    required init(task: TaskObject) {
        self.task = task
    }
    
    func setProgress(_ progress: Int) throws {
        throw ProgressError.cannotSetProgressInNotStartedState
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
        task?._setStartDate(Date())
        task?._setProgress(0)
        task?._setTaskStatus(.inProgress)
        task?.transitionToState(.inProgress)
    }
    
    func completeTask() throws {
        throw TaskValidationError.cannotCompleteWithoutStarting
    }
    
    func validateState() throws {
        // Validate expected dates if both are set
        if let expectedStart = task?.expectedStartDate,
           let expectedDeadline = task?.expectedDeadline,
           expectedStart > expectedDeadline {
            throw TaskValidationError.expectedDeadlineBeforeStart
        }
    }

}
