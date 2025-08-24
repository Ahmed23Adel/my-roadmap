//
//  HomeCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct HomeCoordinatorView: View {
    @StateObject private var homeCoordinator = HomeCoordinator()
    @EnvironmentObject var globalCoordinator: Coordinator
    
    var body: some View {
        NavigationStack(path: $homeCoordinator.navigationPath) {
            HomeView()
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .settings:
                        SettingsView()
                    case .home:
                        EmptyView()
                    }
                }
        }
        .environmentObject(homeCoordinator)
    }
}

#Preview {
    HomeCoordinatorView()
        .environmentObject(HomeCoordinator())
}
