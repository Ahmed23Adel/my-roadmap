//
//  State.swift
//  myRoadmap
//
//  Created by ahmed on 14/05/2025.
//

import Foundation
/*
    Could be either branch or task
 */

protocol GenericState: AnyObject, Identifiable{
    var id: UUID { get }
    var type: StateType { get }
    var title: String { get }
    var progress: Int { get }
    var startDate: Date? { get }
    var completed: Bool { get } // By default it shold be false
    var completedAt: Date? { get } // By default it will be nil
    var expectedDeadline: Date? { get } // by default states may not have deadlines
 
    
   
    
    func setProgress(_ progress: Int) throws
    
}


