//
//  CreatableRoadmab.swift
//  my roadmap
//
//  Created by ahmed on 06/08/2025.
//

import Foundation
import Combine

class CreatableRoadmab{
    @Published var name = ""
    @Published var roadmap = Roadmap()
    private var isBranchInitialized: Bool = false
    private var branch: TaskBranch?
    private var lastNumListsInLastBranch = 0
    
    func appendTask(_ singleTask: TaskObject){
        roadmap.append(singleTask)
    }
    
    func initBranch(title: String){
        isBranchInitialized = true
        lastNumListsInLastBranch = 0
        branch = TaskBranch(title: title)
    }
    func addListOfTasks(_ tasks: ListOfTasks){
        lastNumListsInLastBranch += 1
        guard let branch = branch else {
            return
        }
        guard lastNumListsInLastBranch <= 2 else{
           return
        }
        try! branch.addBranch(branch: tasks)
    }
    
    func finishBranch(){
        roadmap.append(branch!)
        flushOldBranch()
        
    }
    
    func flushOldBranch(){
        branch = nil
        lastNumListsInLastBranch = 0
    }
    
    func save(){
        let roadmapString = roadmap.getJson()
        let jsonSaver = try! LocalJsonFileSaver(fileName: "\(name).json")
        do{
            try jsonSaver.save(jsonString: roadmapString)
        } catch {
            print("error saving", error)
        }
    }
    
}
