//
//  TaskBookErrors.swift
//  myRoadmap
//
//  Created by ahmed on 17/05/2025.
//

import Foundation

enum TaskBookError: Error{
    case cannotSetPagesReadInNotStartedTaskBookState
    case numPagesInBookLessThanOrEqualToZero
    case numPagesInBookLessThanZero
    case pagesReadLessThanZero
    case pagesReadGreaterThanNumberOfPagesInBook
    case titleCannotBeEmpty
    case pagesReadIsGreaaterThanZeroWhileNotStartedTaskBook
    case cannotSetPagesReadInCompletedTaskBookState
}
