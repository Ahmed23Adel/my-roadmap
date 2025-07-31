//
//  ProgressError.swift
//  myRoadmap
//
//  Created by ahmed on 14/05/2025.
//

import Foundation

enum ProgressError: Error{
    
    case progressLessThanZero
    case progressGreaterThan100
    case progressDrewback
    case newProgressValueIsEqualToOldOne
    case cannotSetProgressInNotStartedState
    case cannotSetProgressInCompletedState
    
}
