//
//   TaskValidationError.swift
//  myRoadmap
//
//  Created by ahmed on 14/05/2025.
//

import Foundation

enum TaskValidationError: Error {
    case startDateMissing
    case completedAtMissing
    case completedBeforeStart
    case startDateInFuture
    case expectedDeadlineBeforeStart
    case invalidExpectedTimeRange
    case invalidStateTransition
    case cannotChangeProgressInCurrentState
    case emptyTitle
    case cannotModifyCompletedTask
    case cannotSetCompletionAttributesManually
    case cannotModifyStartDateDirectly
    case completedAttributeCanOnlyBeSetByCompletingTask
    case noStateAfterCompletion
    case cannotCompleteWithoutStarting
    case cannotSetStartDateInCompletedState
    case cannotSetStartDateInPastWhileCreatingTheTask
    case invalidProgressForInProgressTask
    case invalidProgressForCompletedTask
    case taskNotMarkedAsCompleted
    case completedAtBeforeStartDate
    case expectedStartDateInPast
    case cannotStartAnInProgressTask
    case cannotComplteACompletedTask
    case cannotStartTaskInCompletedState
}

