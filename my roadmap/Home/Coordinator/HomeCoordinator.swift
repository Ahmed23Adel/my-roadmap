//
//  HomeCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 13/08/2025.
//

import Foundation
import Combine
import SwiftUI

class HomeCoordinator: ObservableObject{
    @Published var currentRoute: HomeRoute = .home
    @Published var navigationPath = NavigationPath()
    
    func push(_ route: HomeRoute){
        navigationPath.append(route)
    }
    
    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    func navigateTo(_ route: HomeRoute){
        navigationPath = NavigationPath()
        currentRoute = route
    }
    
    // Add methods to navigate to specific screens
    func navigateToSettings() {
        push(.settings)
    }
    
//    func navigateToAddRoadmap() {
//        push(.addNewRoadmap)
//    }
}
