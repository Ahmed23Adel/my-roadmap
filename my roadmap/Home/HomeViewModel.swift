//
//  HomeViewModel.swift
//  my roadmap
//
//  Created by ahmed on 31/07/2025.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject{
    var mainCoordinator: Coordinator?
    var homeCoordinator: HomeCoordinator?
    
    @Published private var roadmap: Roadmap
    @Published var isLoadingRoadmap = false
    
    private let defaultRoadmapReader = DefaultRoadmapReader()
    private var currentRoadmapName: String = ""
    
    @AppStorage(GlobalConstants.selectedRoadmapKey) var defaultRoadmapName: String = ""
    
    @Published var showSheet = false
    @Published var selectedSheet: TaskObject?
    
    init(){
        roadmap = defaultRoadmapReader.read()
        currentRoadmapName = defaultRoadmapName
        
    }
    
    func setMainCoordinator(coordinator: Coordinator){
        self.mainCoordinator = coordinator
    }
    
    func setHomeCoordinator(coordinator: HomeCoordinator){
        self.homeCoordinator = coordinator
    }
    
    func getRoadmap() -> Roadmap{
        roadmap.calcEachTaskPosition()
        return roadmap
    }
    
    func getRoadmapName() -> String{
        if currentRoadmapName.isEmpty{
            return defaultRoadmapName
        }
        return currentRoadmapName
    }
    
    func navigateToAddNewRoadmap(){
        mainCoordinator?.navigateTo(.addNewRoadmap)
    }
    
    func navigateToSettings(){
        homeCoordinator?.push(.settings)
    }
    
    func showSheetForTask(singleTask: TaskObject){
        selectedSheet = singleTask
        showSheet = true
    }
    
    func updateRoadmapName(_ name: String) {
        guard currentRoadmapName != name else { return }
        
        print("Starting roadmap update from '\(currentRoadmapName)' to '\(name)'")
        
        // Step 1: Set loading state - this prevents UI from rendering
        isLoadingRoadmap = true
        
        // Step 2: Update the name
        currentRoadmapName = name
        
        // Step 3: Load new roadmap asynchronously
        DispatchQueue.global(qos: .userInitiated).async {
            let newRoadmap = self.defaultRoadmapReader.read()
            print("New roadmap loaded with \(newRoadmap.count) tasks")
            
            // Step 4: Update UI on main thread after roadmap is fully loaded
            DispatchQueue.main.async {
                self.roadmap = newRoadmap
                self.isLoadingRoadmap = false  // This triggers UI to render
                print("Roadmap update completed and UI notified")
            }
        }
    }
}
