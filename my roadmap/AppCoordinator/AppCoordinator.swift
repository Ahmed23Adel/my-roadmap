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
        Group { //START: Group
            if let _ = configHolder.config { //START: Check configHolder
                // Wrap the switching logic in a transition container
                Group {
                    switch coordinator.currentRoute { //START: switch
                    case .signup:
                        SignupView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    case .home:
                        HomeCoordinatorView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    case .login:
                        LoginView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    case .addNewRoadmap:
                        AddNewRoadmapCoordinatorView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    }
                }  //END: switch
                .animation(.easeInOut(duration: 0.3), value: coordinator.currentRoute)
            } else { //START: else Check configHolder
                FixedProgressView()
            } //END: else Check configHolder
        } //End: Group
        .task {
            await configHolder.loadConfig()
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    AppCoordinator()
}
