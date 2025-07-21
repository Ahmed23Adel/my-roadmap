//
//  AppCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct AppCoordinator: View {
    @EnvironmentObject var configHolder: AdelsonConfigHolder
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        Group {
            if let config = configHolder.config{
                switch coordinator.currentRoute {
                case .signup:
                    SignupView()
                case .home:
                    HomeCoordinator()
                case .settings:
                    SettingsView()
                    
                }
            } else{
                ProgressView("Loadding...")
            }
        }
        .task{
            await configHolder.loadConfig()
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    AppCoordinator()
}
