//
//  ListOfTasks.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import Foundation

class ListOfTasks: TaskObject{
    private(set) var tasks: [TaskObject] = []
    
    func addTask(_ task: TaskObject) {
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
    let totalMarginHeight = CGFloat(max(0, tasks.count - 1)) * DrawableConstants.margin  // N-1 margins
    
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

}
