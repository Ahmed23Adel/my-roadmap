//
//  Coordinator.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import Foundation
import SwiftUI
import Combine

class Coordinator: ObservableObject {
    @Published var currentRoute: Route = .signup
    @Published var navigationPath = NavigationPath()
    @Published var presentedSheet: Sheet?
    
    init() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            currentRoute = .home
        }
    }
    
    // Navigate to a completely new root view (replaces current view)
    func navigateTo(_ route: Route) {
        currentRoute = route
        navigationPath = NavigationPath() // Clear navigation stack
    }
    
    // Push to navigation stack (for hierarchical navigation)
    func push(_ route: Route) {
        navigationPath.append(route)
    }
    
    // Pop from navigation stack
    func pop() {
        navigationPath.removeLast()
    }
    
    // Show sheet
    func showSheet(_ sheet: Sheet) {
        presentedSheet = sheet
    }
    
    // Dismiss sheet
    func dismissSheet() {
        presentedSheet = nil
    }
    
    func login() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        navigateTo(.home)
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        navigateTo(.signup)
    }
}
