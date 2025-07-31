//
//  TaskGoalError.swift
//  myRoadmap
//
//  Created by ahmed on 20/05/2025.
//

import Foundation
enum TaskGoalError: Error {
    case detailsCannotBeEmpty
    case invalidImageUrl
    case cannotUpdateDetailsInNotStartedGoalState
    case cannotUpdateDetailsInCompletedGoalState
    case cannotUpdateImageLinkInNotStartedGoalState
    case cannotUpdateImageLinkInCompletedGoalState
    case cannotUpdateDetailsInInProgressState
    case cannotUpdateImageLinkInInProgressState
}
