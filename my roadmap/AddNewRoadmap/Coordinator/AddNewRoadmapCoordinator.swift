//
//  AddNewRoadmapCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 06/08/2025.
//

import Foundation
import Combine
import SwiftUI

class AddNewRoadmapCoordinator: ObservableObject{
    @Published var navigationPath = NavigationPath()

    
    func push(_ route: AddNewRoadmapRoute){
        navigationPath.append(route)
    }
    
    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    func reset() {
        navigationPath = NavigationPath()
    }
}
