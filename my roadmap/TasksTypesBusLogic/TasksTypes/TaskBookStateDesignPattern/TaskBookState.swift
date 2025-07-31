//
//  TaskBookState.swift
//  myRoadmap
//
//  Created by ahmed on 17/05/2025.
//

import Foundation

protocol TaskBookState{
    var taskBook: TaskBook? { get set}
    
    init (taskBook: TaskBook)
    
    func setNumPagesRead(_ pagesRead: Int) throws
    func increaseNumPagesReadBy(_ pagesRead: Int) throws
}
