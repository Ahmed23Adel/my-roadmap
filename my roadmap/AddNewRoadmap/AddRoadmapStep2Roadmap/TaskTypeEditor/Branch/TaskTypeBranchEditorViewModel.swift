//
//  TaskTypeBranchEditorViewModel.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import Foundation
import Combine
import SwiftUI

class TaskTypeBranchEditorViewModel: ObservableObject{
    private var mainCoordinator: AddNewRoadmapCoordinator?
    private var chooseTaskTypeCoordinator: ChooseTaskTypeCoordinator?
    private var branchCoordinator: BranchCoordinator?
    
    @Published var taskTitle: String = "FixedTitle"
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
        print("h1")
        if validateInputs(){
            print("h2")
            mainCoordinator?.creatableRoadmap.initBranch(title: taskTitle)
            mainCoordinator?.creatableRoadmap.addListOfTasks(branchCoordinator!.tasksList1)
            mainCoordinator?.creatableRoadmap.addListOfTasks(branchCoordinator!.tasksList2)
            mainCoordinator?.creatableRoadmap.finishBranch()
            chooseTaskTypeCoordinator?.navigateTo(.chooseType)
        } else{
            print("h3")
            showErrorAlert()
        }
        
        
        
    }
    
    
    func validateInputs()->Bool{
        return !branchCoordinator!.tasksList1.isEmpty && !branchCoordinator!.tasksList2.isEmpty
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
        print("isDisabledGlobal1")
        guard let coordinator = branchCoordinator else { return true }
        print("isDisabledGlobal2")
        return coordinator.tasksList1.isEmpty || coordinator.tasksList2.isEmpty || taskTitle.isEmpty
    }
    
    func cancel(){
        chooseTaskTypeCoordinator?.navigateTo(.chooseType)
    }
    
    
    func showErrorAlert(){
        showError = true
        errorMsg = "Each branch must have at least one task"
    }
}
