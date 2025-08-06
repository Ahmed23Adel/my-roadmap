//
//  AddNewRoadmapCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 06/08/2025.
//

import SwiftUI

struct AddNewRoadmapCoordinatorView: View {
    @StateObject private var addNewRoadmapCoordinator = AddNewRoadmapCoordinator()
    @EnvironmentObject var mainCoordinator: Coordinator
    
    var body: some View {
        NavigationStack(path: $addNewRoadmapCoordinator.navigationPath) {
            AddRoadmapStep1NameView()
                .navigationDestination(for: AddNewRoadmapRoute.self) { route in
                    switch route {
                    // We don't need .nameStep here since NameStepView is already the root
                    case .roadmapStep:
                        AddRoadmapStep2Roadmap()
                    case .completed:
                        AddRoadmapStep3Completed()
                    case .nameStep:
                        // This would create a duplicate, so we can omit it or handle differently
                        EmptyView()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            // Go back to main navigation
                            mainCoordinator.navigateTo(.home)
                        }
                    }
                }
        }
        .environmentObject(addNewRoadmapCoordinator)
    }
}
#Preview {
    AddNewRoadmapCoordinatorView()
}
