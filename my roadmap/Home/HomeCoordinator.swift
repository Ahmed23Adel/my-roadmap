//
//  HomeCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct HomeCoordinator: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            HomeView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .settings:
                        EditProfileView()
                    case .addNewRoadmap:
                        AddNewRoadmapCoordinatorView()
                    default:
                        EmptyView()
                    }
                }
        }
        
    }
}

#Preview {
    HomeCoordinator()
}
