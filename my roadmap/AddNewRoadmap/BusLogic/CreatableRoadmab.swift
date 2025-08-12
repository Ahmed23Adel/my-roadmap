//
//  CreatableRoadmab.swift
//  my roadmap
//
//  Created by ahmed on 06/08/2025.
//

import Foundation
import Combine
import SwiftUI

class CreatableRoadmab: ObservableObject{
    @Published var name = ""
    @Published var roadmap = Roadmap()
    private var isBranchInitialized: Bool = false
    private var branch: TaskBranch?
    private var lastNumListsInLastBranch = 0
    
    func appendTask(_ singleTask: any GenericState){
        withAnimation{
            roadmap.append(singleTask)
        }
        
        roadmap.calcEachTaskPosition()
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
        withAnimation{
            roadmap.append(branch!)
        }
        flushOldBranch()
        roadmap.calcEachTaskPosition()
        
    }
    
    func flushOldBranch(){
//        branch = nil
        lastNumListsInLastBranch = 0
    }
    
    func save(){
        let roadmapString = roadmap.getJson()
        print("roadmapString", roadmapString)
        let jsonSaver = try! LocalJsonFileSaver(fileName: FileNameCreator().create(fileName: name))
        do{
            try jsonSaver.save(jsonString: roadmapString)
        } catch {
            print("error saving", error)
        }
    }
    
    
    
    func getRoadmap() -> Roadmap{
        roadmap.calcEachTaskPosition()
        return roadmap
    }
    
    func pop(){
        withAnimation{
            roadmap.pop()
        }
        
        roadmap.calcEachTaskPosition()
    }
}
