//
//  Roadmap.swift
//  my roadmap
//
//  Created by ahmed on 03/08/2025.
//

import Foundation
import Combine

class Roadmap: ObservableObject, JsonExtractor{
    
    
    @Published private(set) var roadmap: [any GenericState] = []
    @Published private(set) var roadmapName: String = ""
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
    
}
