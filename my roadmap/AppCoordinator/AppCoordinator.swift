//
//  AppCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI
struct AppCoordinator: View {
    @ObservedObject var configHolder = AdelsonConfigHolder.shared
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        Group {
            if let _ = configHolder.config {
                // Wrap the switching logic in a transition container
                Group {
                    switch coordinator.currentRoute {
                    case .signup:
                        SignupView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    case .home:
                        HomeCoordinator()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    case .settings:
                        SettingsView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity),
                                removal: .move(edge: .top).combined(with: .opacity)
                            ))
                    case .login:
                        LoginView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: coordinator.currentRoute)
            } else {
                ProgressView("Loading...")
                    .transition(.opacity)
            }
        }
        .task {
            await configHolder.loadConfig()
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    AppCoordinator()
}
