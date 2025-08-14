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
    @AppStorage(GlobalConstants.selectedRoadmapKey) var defaultRoadmapName: String = ""
    
    init(){
        let defaultRoadmapReader = DefaultRoadmapReader()
        roadmap = defaultRoadmapReader.read()
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
        defaultRoadmapName
    }
    
    func navigateToAddNewRoadmap(){
        mainCoordinator?.navigateTo(.addNewRoadmap)
    }
    
    func navigateToSettings(){
        homeCoordinator?.push(.settings)
    }
    
    
}
