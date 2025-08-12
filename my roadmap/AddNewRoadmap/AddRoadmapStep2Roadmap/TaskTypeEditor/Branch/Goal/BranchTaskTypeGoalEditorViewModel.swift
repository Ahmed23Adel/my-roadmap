//
//  TaskTypeCourseEditorViewModel.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import Foundation
import Combine

class BranchTaskTypeGoalEditorViewModel: ObservableObject{
    private var mainCoordinator: AddNewRoadmapCoordinator?
    private var branchCoordinator: BranchCoordinator?
    
    @Published var taskTitle: String = ""
    @Published var details: String = ""
    @Published var expectedStartDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @Published var expectedDeadline: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    
    @Published var showError = false
    @Published var errorMsg = ""
    
    private var tasksList1: ListOfTasks?
    private var tasksList2: ListOfTasks?
    
    func setMainCoordinator(coordinator: AddNewRoadmapCoordinator){
        self.mainCoordinator = coordinator
    }
    
    func setBranchCoordinator(coordinator: BranchCoordinator){
        self.branchCoordinator = coordinator
    }
    
    func isFormValid()-> Bool{
        !taskTitle.isEmpty && !details.isEmpty 
    }
    
    func setTasksLists(tasksList1: ListOfTasks, tasksList2: ListOfTasks) {
        self.tasksList1 = tasksList1
        self.tasksList2 = tasksList2
    }
    
    func addTask() {
        guard let currentListIndex = branchCoordinator?.currentListIndex else {
            errorMsg = "No list selected"
            showError = true
            return
        }
        
        let targetList: ListOfTasks?
        
        switch currentListIndex {
        case branchCoordinator?.list1Index:
            targetList = tasksList1
        case branchCoordinator?.list2Index:
            targetList = tasksList2
        default:
            errorMsg = "Invalid list index"
            showError = true
            return
        }
        
        guard let tasksList = targetList else {
            errorMsg = "Target tasks list not available"
            showError = true
            return
        }
        
        do {
            let newTask = try TaskGoal.createNotStartedGoal(
                details: details,
                imageLink: nil,
                title: taskTitle,
                expectedStartDate: expectedStartDate,
                expectedDeadline: expectedDeadline)
            tasksList.append(newTask)
            branchCoordinator?.navigateTo(.taskTypeBranch)
            
        } catch {
            errorMsg = "Error occurred while adding task. \(error)"
            showError = true
        }
    }
}
