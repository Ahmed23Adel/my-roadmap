//
//  RoadmapCanvasViewModel.swift
//  my roadmap
//
//  Created by ahmed on 03/08/2025.
//

import Foundation
import Combine
import SwiftUI

class RoadmapCanvasViewModel: ObservableObject{
    @Published var roadmap: Roadmap
    
    init(roadmap: Roadmap){
        self.roadmap = roadmap
    }
    
    
    func getRoadmapName() -> String{
        "Testable Roadmap"
    }
    
}
