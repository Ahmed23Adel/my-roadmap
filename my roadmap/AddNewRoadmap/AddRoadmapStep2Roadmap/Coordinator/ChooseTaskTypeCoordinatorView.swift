//
//  ChooseTaskTypeCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import SwiftUI

struct ChooseTaskTypeCoordinatorView: View {
    @ObservedObject var coordinator = ChooseTaskTypeCoordinator()
    var body: some View {
        Group{
            switch coordinator.currentRoute { //START: switch
            case .chooseType:
                ChooseTaskTypeView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .book:
                TaskTypeBookEditor()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            default:
                EmptyView()
            }
        }
        .environmentObject(coordinator)
    }
}
#Preview {
    ChooseTaskTypeCoordinatorView()
}
