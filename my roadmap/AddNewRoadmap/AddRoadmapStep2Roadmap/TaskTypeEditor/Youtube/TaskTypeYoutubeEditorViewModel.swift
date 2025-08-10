//
//  TaskTypeYoutubeEditorViewModel.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import Foundation
import Combine

class TaskTypeYoutubeEditorViewModel: ObservableObject{
    private var mainCoordinator: AddNewRoadmapCoordinator?
    private var chooseTaskTypeCoordinator: ChooseTaskTypeCoordinator?
    
    @Published var taskTitle: String = ""
    @Published var playlistName: String = ""
    @Published var videoCount: String = ""
    @Published var linkToYoutube: String = ""
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
        !taskTitle.isEmpty && !playlistName.isEmpty && !videoCount.isEmpty && !linkToYoutube.isEmpty
    }
    
    func addTask(){
        do {
            let newTask = try TaskYoutubePlaylist.createNotStartedYoutubePlaylist(
                playlistName: playlistName,
                videoCount: Int(videoCount)!,
                linkToYoutube: linkToYoutube,
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
