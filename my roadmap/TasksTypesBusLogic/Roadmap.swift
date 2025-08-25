//
//  Roadmap.swift
//  my roadmap
//
//  Created by ahmed on 03/08/2025.
//

import Foundation
import Combine
import SwiftUI

class Roadmap: ObservableObject, JsonExtractor{
    
    
    @Published private(set) var roadmap: [any GenericState] = []
    @AppStorage(GlobalConstants.selectedRoadmapKey) var defaultRoadmapName: String = ""
    
    var count: Int{
        roadmap.count
    }
    
    subscript(index: Int) -> any GenericState{
        roadmap[index]
    }
    
    func initTestableRoadmap(){
        var currentDate: Date {
            return Date()
        }
        
        var pastDate: Date {
            return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        }
        
        var futureDate: Date {
            return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
        }
        
        var tasks: [any GenericState] = []
        try! tasks.append(TaskBook.createNotStartedBook(bookName: "Clean Code", numPagesInBook: 300, title: "Read this book", expectedStartDate: futureDate, expectedDeadline: futureDate))
        
        
        let listTasks1 = ListOfTasks(title: "First List")
        try! listTasks1.append(TaskArticle.createNotStartedArticle(articleName: "learn iOS", linkToArticle: "https://google.com", title: "learn this", expectedStartDate: futureDate, expectedDeadline: futureDate))
        try! listTasks1.append(TaskArticle.createNotStartedArticle(articleName: "learn Android", linkToArticle: "https://google.com", title: "learn this", expectedStartDate: futureDate, expectedDeadline: futureDate))
        
        
        let listTasks2 = ListOfTasks(title: "Second List")
        try! listTasks2.append(TaskArticle.createNotStartedArticle(articleName: "learn web", linkToArticle: "https://google.com", title: "learn this", expectedStartDate: futureDate, expectedDeadline: futureDate))
        
        let branch = TaskBranch(title: "branch")
        try! branch.addBranch(branch: listTasks1)
        try! branch.addBranch(branch: listTasks2)
        
        tasks.append(branch)
        
        try! tasks.append(TaskYoutubePlaylist.createNotStartedYoutubePlaylist(playlistName: "learn HTML", videoCount: 25, linkToYoutube: "https://www.youtube.com/watch?v=AphNalSmvlk", title: "learn this", expectedStartDate: futureDate, expectedDeadline: futureDate))
        
        self.roadmap = tasks
    }
    
    
    func calcEachTaskPosition() {
        let startX = DrawableConstants.startRoadmapX
        let startY = DrawableConstants.startRoadmapY + DrawableConstants.startImgHeight + DrawableConstants.margin
        
        positionTasksRecursively(tasks: roadmap, startX: startX, startY: startY)
    }
    
    func positionTasksRecursively(tasks: [any GenericState], startX: CGFloat, startY: CGFloat) {
        var curX = startX
        var curY = startY
        
        for var singleTask in tasks {
            if let branchTask = singleTask as? TaskBranch {
                let branchHeight = branchTask.calcHeight()
                
                // Position branch at current location (center reference point)
                branchTask.posX = curX
                branchTask.posY = curY
                
                // Get the two parallel lists
                let listOfTasks1 = branchTask.parallelBranches[0]
                let listOfTasks2 = branchTask.parallelBranches[1]
                
                // Calculate widths
                let list1Width = listOfTasks1.calcWidth()
                let list2Width = listOfTasks2.calcWidth()
                let totalWidth = list1Width + DrawableConstants.margin + list2Width
                let centerOffset = totalWidth / 2
                
                // FIXED: Position List1 (left side of center) - add half width for center positioning
                let list1StartX = curX - centerOffset + DrawableConstants.width/2
                calcListOfTasks(listOfTasks: listOfTasks1, startX: list1StartX, startY: curY)
                
                // FIXED: Position List2 (right side of center) - add half width for center positioning
                let list2StartX = curX - centerOffset + list1Width + DrawableConstants.margin + DrawableConstants.width/2
                calcListOfTasks(listOfTasks: listOfTasks2, startX: list2StartX, startY: curY)
                
                curY += branchHeight + DrawableConstants.margin 
                
            } else {
                // FIXED: Position single task - add half height for center positioning
                singleTask.posX = curX
                singleTask.posY = curY + DrawableConstants.height/2
                
                curY += singleTask.calcHeight() + DrawableConstants.margin
            }
        }
    }

    private func calcListOfTasks(listOfTasks: ListOfTasks, startX: CGFloat, startY: CGFloat) {
        var curY = startY
        
        // Position the list itself
        listOfTasks.posX = startX
        listOfTasks.posY = startY
        
        // FIXED: Position all tasks with center positioning in mind
        for singleTask in listOfTasks.tasks {
            singleTask.posX = startX  // X is already adjusted for center in the caller
            singleTask.posY = curY + DrawableConstants.height/2  // Add half height for center positioning
            
            curY += singleTask.calcHeight() + DrawableConstants.margin
        }
    }
 
    
    
    
    func getJson() -> String {
        var taskJsons: [String] = []
        
        for singleTask in roadmap {
            let jsonForTask = singleTask.getJson()
            taskJsons.append(jsonForTask)
        }
        
        // Join all task JSONs with commas and wrap in array brackets
        let roadmapArrayJson = "[" + taskJsons.joined(separator: ",") + "]"
        
        return roadmapArrayJson
    }
    
    func append(_ singleTask: any GenericState){
        self.roadmap.append(singleTask)
    }
    
    
    func pop(){
        if self.roadmap.count > 0 {
            self.roadmap.removeLast()
        }
    }
    
    func isPrevTaskFinished(singleTask: TaskObject) -> Bool {
        // Find the task's position in the roadmap
        if let taskPosition = findTaskPosition(singleTask: singleTask) {
            return isPreviousItemCompleted(at: taskPosition)
        }
        return false // Task not found in roadmap
    }

    private func findTaskPosition(singleTask: TaskObject) -> TaskPosition? {
        for (roadmapIndex, item) in roadmap.enumerated() {
            if let task = item as? TaskObject {
                if task.id == singleTask.id {
                    return TaskPosition(roadmapIndex: roadmapIndex, branchIndex: nil, taskIndex: nil)
                }
            } else if let branch = item as? TaskBranch {
                for (branchIndex, tasks) in branch.parallelBranches.enumerated() {
                    for (taskIndex, task) in tasks.enumerated() {
                        if task.id == singleTask.id {
                            return TaskPosition(roadmapIndex: roadmapIndex, branchIndex: branchIndex, taskIndex: taskIndex)
                        }
                    }
                }
            }
        }
        return nil
    }

    private func isPreviousItemCompleted(at position: TaskPosition) -> Bool {
        // If task is in a branch
        if let branchIndex = position.branchIndex, let taskIndex = position.taskIndex {
            // If it's the first task in the branch, check previous roadmap item
            if taskIndex == 0 {
                return isPreviousRoadmapItemCompleted(at: position.roadmapIndex)
            } else {
                // Check previous task in the same branch
                guard let branch = roadmap[position.roadmapIndex] as? TaskBranch,
                      branchIndex < branch.parallelBranches.count,
                      taskIndex > 0,
                      taskIndex <= branch.parallelBranches[branchIndex].count else {
                    return false
                }
                return branch.parallelBranches[branchIndex][taskIndex - 1].taskStatus == .completed
            }
        } else {
            // Task is directly in roadmap (not in a branch)
            return isPreviousRoadmapItemCompleted(at: position.roadmapIndex)
        }
    }

    private func isPreviousRoadmapItemCompleted(at roadmapIndex: Int) -> Bool {
        // First item in roadmap has no previous item
        if roadmapIndex == 0 {
            return true
        }
        
        guard roadmapIndex > 0 && roadmapIndex < roadmap.count else {
            return false
        }
        
        let previousItem = roadmap[roadmapIndex - 1]
        
        if let previousTask = previousItem as? TaskObject {
            return previousTask.taskStatus == .completed
        } else if let previousBranch = previousItem as? TaskBranch {
            return isBranchCompleted(previousBranch)
        }
        
        return false
    }

    private func isBranchCompleted(_ branch: TaskBranch) -> Bool {
        // Branch is completed when all parallel branches are completed
        // Each parallel branch is completed when its last task is completed
        guard branch.parallelBranches.count == 2 else {
            return false // Expecting exactly 2 branches as per requirement
        }
        
        for parallelBranch in branch.parallelBranches {
            guard !parallelBranch.isEmpty else {
                return false // Empty branch shouldn't exist
            }
            
            // Check if the last task in this parallel branch is completed
            let lastTask = parallelBranch.last!
            if lastTask.taskStatus != .completed {
                return false
            }
        }
        
        return true
    }

    // Helper struct to represent task position
    private struct TaskPosition {
        let roadmapIndex: Int
        let branchIndex: Int?
        let taskIndex: Int?
    }

    
    func updateChanges(){
        let roadmapString = self.getJson()
        print("roadmapString", roadmapString)
        
        let fileName = FileNameCreator().create(fileName: defaultRoadmapName)
        print("Generated filename:", fileName)
        
        do {
            let jsonSaver = try LocalJsonFileSaver(fileName: fileName)
            try jsonSaver.save(jsonString: roadmapString)
            print("File saved successfully to:", fileName)
        } catch {
            print("Error saving:", error)
        }
    }
}
