//
//  Coordinator.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import Foundation
import SwiftUI
import Combine

/// A global app coordinator that manages high-level navigation and sheet presentation.
class Coordinator: ObservableObject {
    
    /// The current root route of the app (e.g. home, signup).
    @Published var currentRoute: Route = .signup

    /// The current navigation path used by NavigationStack for hierarchical navigation.
    @Published var navigationPath = NavigationPath()
    
    /// The currently presented sheet, if any.
    @Published var presentedSheet: Sheet?

    /// Initializes the coordinator and checks if the user is already logged in.
    init() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            currentRoute = .home
        }
    }

    /// Navigates to a new root route, resetting the navigation stack.
    /// - Parameter route: The route to navigate to.
    func navigateTo(_ route: Route) {
        currentRoute = route
        navigationPath = NavigationPath()
    }

    /// Pushes a route onto the navigation stack for deeper navigation.
    /// - Parameter route: The route to push.
    func push(_ route: Route) {
        navigationPath.append(route)
    }

    /// Pops the top route off the navigation stack.
    func pop() {
        navigationPath.removeLast()
    }

    /// Presents a sheet modally.
    /// - Parameter sheet: The sheet to show.
    func showSheet(_ sheet: Sheet) {
        presentedSheet = sheet
    }

    /// Dismisses any currently presented sheet.
    func dismissSheet() {
        presentedSheet = nil
    }

    /// Logs the user in and navigates to the home screen.
    func login() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        navigateTo(.home)
    }

    /// Logs the user out and navigates to the signup screen.
    func logout() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        navigateTo(.signup)
    }
}

