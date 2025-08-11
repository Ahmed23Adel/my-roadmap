//
//  ListOfTasks.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import Foundation
import Combine

class ListOfTasks: TaskObject, RandomAccessCollection{
    @Published private(set) var tasks: [TaskObject] = []
    
    var isEmpty: Bool{
        tasks.isEmpty
    }
    
    func append(_ task: TaskObject) {
        tasks.append(task)
    }
    
    func isListCompleted()-> Bool{
        guard tasks.count > 0 else {
            return true
        }
        return tasks.last?.taskStatus == .completed
    }
    
    override func calcHeight() -> CGFloat {
    guard !tasks.isEmpty else { return 0 }
    
    let taskHeight = DrawableConstants.height
    let totalTaskHeight = CGFloat(tasks.count) * taskHeight
        let totalMarginHeight = CGFloat(Swift.max(0, tasks.count - 1)) * DrawableConstants.margin  // N-1 margins
    
    return totalTaskHeight + totalMarginHeight
        }
    
    override func calcWidth() -> CGFloat {
        DrawableConstants.width
    }
    
    // MARK: JsonExtractor
    override func getJson() -> String {
        var taskJsons: [String] = []
        for singleTask in tasks {
            taskJsons.append(singleTask.getJson())
        }
        let tasksArrayJson = "[" + taskJsons.joined(separator: ",") + "]"
        
        return tasksArrayJson
    }

    
    // MARK: - RandomAccessCollection Conformance
        typealias Index = Int
        // Start index (always 0 for arrays)
        var startIndex: Int {
            return tasks.startIndex
        }
        
        // End index (count of elements)
        var endIndex: Int {
            return tasks.endIndex
        }
        
        // Subscript to access elements by index
        subscript(position: Int) -> TaskObject {
            return tasks[position]
        }
        
        // Method to get the next index
        func index(after i: Int) -> Int {
            return tasks.index(after: i)
        }
        
        // Method to get the previous index (required for BidirectionalCollection)
        func index(before i: Int) -> Int {
            return tasks.index(before: i)
        }
}
