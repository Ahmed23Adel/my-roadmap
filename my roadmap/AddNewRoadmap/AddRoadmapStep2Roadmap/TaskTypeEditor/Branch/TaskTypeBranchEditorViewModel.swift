//
//  TaskTypeBranchEditorViewModel.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import Foundation
import Combine

class TaskTypeBranchEditorViewModel: ObservableObject{
    private var mainCoordinator: AddNewRoadmapCoordinator?
    private var chooseTaskTypeCoordinator: ChooseTaskTypeCoordinator?
    private var branchCoordinator: BranchCoordinator?
    
    @Published var taskTitle: String = ""
    @Published var list1Title: String = ""
    @Published var list2Title: String = ""
    
    @Published var showError = false
    @Published var errorMsg = ""
    

    func setMainCoordinator(coordinator: AddNewRoadmapCoordinator){
        self.mainCoordinator = coordinator
    }
    
    func setChooseTaskTypeCoordinator(coordinator: ChooseTaskTypeCoordinator){
        self.chooseTaskTypeCoordinator = coordinator
    }
    
    func setBranchCoordinator(coordinator: BranchCoordinator){
        self.branchCoordinator = coordinator
    }
    
    func addTask(){
        do {
            let branch = TaskBranch(title: taskTitle)
            
            
            
//            try branch.addBranch(branch: listOfTasks1)
//            try branch.addBranch(branch: listOfTasks2)
//            mainCoordinator?.creatableRoadmap.initBranch(title: taskTitle)
//            mainCoordinator?.creatableRoadmap.addListOfTasks(listOfTasks1)
//            mainCoordinator?.creatableRoadmap.addListOfTasks(listOfTasks2)
//            mainCoordinator?.creatableRoadmap.finishBranch()
            
            chooseTaskTypeCoordinator?.navigateTo(.chooseType)
        } catch {
            errorMsg = "Error occured while adding task. \(error)"
            showError = true
        }
        
        
    }
    
    
    func isDisabled()->Bool{
        return false
    }
    
    func addNewTaskList1(){
        branchCoordinator?.currentListIndex = branchCoordinator?.list1Index
        branchCoordinator?.navigateTo(.chooseType)
    }
    
    func addNewTaskList2(){
        branchCoordinator?.currentListIndex = branchCoordinator?.list2Index
        branchCoordinator?.navigateTo(.chooseType)
    }
    
    func isDisabledGlobal() -> Bool {
        guard let coordinator = branchCoordinator else { return true }
        return coordinator.tasksList1.isEmpty || coordinator.tasksList2.isEmpty || taskTitle.isEmpty
    }
    
    func cancel(){
        chooseTaskTypeCoordinator?.navigateTo(.chooseType)
    }
    
    
    
}
