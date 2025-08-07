//
//  AddRoadmapStep2RoadmapViewModel.swift
//  my roadmap
//
//  Created by ahmed on 06/08/2025.
//

import Foundation
import Combine

class AddRoadmapStep2RoadmapViewModel: ObservableObject{
    @Published private var coordinator: AddNewRoadmapCoordinator?
    @Published var showError = false
    @Published var errorMsg = ""
    
    
    func setCoordinator(coordinator: AddNewRoadmapCoordinator){
        self.coordinator = coordinator
    }
    
    
    func back(){
        
    }
    
    var isCoordinatorSet: Bool {
        coordinator != nil
    }
    
    func getRoadmap() -> Roadmap{
        (coordinator?.creatableRoadmap.getRoadmap())!
    }
    
}
