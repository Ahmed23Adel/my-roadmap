//
//  AppCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct AppCoordinator: View {
    @StateObject private var coordinator = Coordinator()
    var body: some View {
        Group {
            switch coordinator.currentRoute {
            case .signup:
                SignupView()
            case .home:
                HomeCoordinator()
            case .settings:
                SettingsView()
                
            }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    AppCoordinator()
}
