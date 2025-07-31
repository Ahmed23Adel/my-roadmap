//
//  GenericTask.swift
//  myRoadmap
//
//  Created by ahmed on 14/05/2025.
//

import Foundation
/*
    The state type will be implmented in the factory method
 */
protocol GenericTask: GenericState{
    var expectedStartDate: Date? { get }
}
