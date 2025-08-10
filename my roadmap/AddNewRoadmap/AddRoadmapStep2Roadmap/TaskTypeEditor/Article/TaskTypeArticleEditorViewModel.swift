//
//  TaskTypeArticleEditorViewModel.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import Foundation
import Combine

class TaskTypeArticleEditorViewModel: ObservableObject{
    private var mainCoordinator: AddNewRoadmapCoordinator?
    private var chooseTaskTypeCoordinator: ChooseTaskTypeCoordinator?
    
    @Published var taskTitle: String = ""
    @Published var articleName: String = ""
    @Published var linkToArticle: String = ""
    @Published var expectedStartDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @Published var expectedDeadline: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    
    @Published var showError = false
    @Published var errorMsg = ""
    
    func setMainCoordinator(coordinator: AddNewRoadmapCoordinator){
        self.mainCoordinator = coordinator
    }
    
    func setSubCoordinator(coordinator: ChooseTaskTypeCoordinator){
        self.chooseTaskTypeCoordinator = coordinator
    }
    
    func isFormValid()-> Bool{
        !taskTitle.isEmpty && !articleName.isEmpty && !linkToArticle.isEmpty
    }
    
    func addTask(){
        do {
            let newTask = try TaskArticle.createNotStartedArticle(
                articleName: articleName,
                linkToArticle: linkToArticle,
                title: taskTitle,
                expectedStartDate: expectedStartDate,
                expectedDeadline: expectedDeadline)
            mainCoordinator?.creatableRoadmap.appendTask(newTask)
            chooseTaskTypeCoordinator?.navigateTo(.chooseType)
        } catch {
            errorMsg = "Error occured while adding task. \(error)"
            showError = true
        }
        
        
    }
}
