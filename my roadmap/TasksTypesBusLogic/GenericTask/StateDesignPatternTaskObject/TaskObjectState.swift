//
//  TaskObjectState.swift
//  myRoadmap
//
//  Created by ahmed on 16/05/2025.
//

import Foundation

protocol TaskObjectState {
    var task: TaskObject? { get }
    
    init (task: TaskObject)
    
    func setProgress(_ progress: Int) throws
    func setTitle(_ title: String) throws
    func setExpectedStartDate(_ date: Date?) throws
    func setExpectedDeadline(_ date: Date?) throws
    func startTask() throws
    func completeTask() throws
    
    func validateState() throws
}
