//
//  InProgressTaskObjectState.swift
//  myRoadmap
//
//  Created by ahmed on 16/05/2025.
//

import Foundation


class InProgressTaskObjectState: TaskObjectState{
    weak var task: TaskObject?
        
    required init(task: TaskObject) {
        self.task = task
    }
    
    func setProgress(_ progress: Int) throws {
        if progress < 0 {
            throw ProgressError.progressLessThanZero
        } else if progress > 100 {
            throw ProgressError.progressGreaterThan100
        } else if progress < task!.progress {
            throw ProgressError.progressDrewback
        } else if progress == task?.progress {
            throw ProgressError.newProgressValueIsEqualToOldOne
        }
        
        task?._setProgress(progress)
        
        // If progress reaches 100, transition to completed state
        if progress == 100 {
            try completeTask()
        }
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
        throw TaskValidationError.cannotStartAnInProgressTask
    }
    
    func completeTask() throws {
        task?._setCompleted(true)
        task?._setCompletedAt(Date())
        task?._setTaskStatus(.completed)
        task?._setProgress(100)
        task?.transitionToState(.completed)
    }
    
    func validateState() throws {
        guard let startDate = task?.startDate else {
            throw TaskValidationError.startDateMissing
        }
        
        if startDate > Date() {
            throw TaskValidationError.startDateInFuture
        }
        
        if task!.progress < 0 || task!.progress > 100 {
            throw ProgressError.progressGreaterThan100
        }
        
        if let expectedStartDate = task?.expectedStartDate,
           let expectedDeadline = task?.expectedDeadline,
           expectedStartDate > expectedDeadline {
            throw TaskValidationError.expectedDeadlineBeforeStart
        }
    }
}
