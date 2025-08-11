//
//  BranchCoordinatorView.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import SwiftUI


struct BranchCoordinatorView: View {
    @ObservedObject var coordinator = BranchCoordinator()
    
    var body: some View {
        Group{
            switch coordinator.currentRoute { //START: switch
            case .taskTypeBranch:
                TaskTypeBranchEditorView(tasksList1: $coordinator.tasksList1, tasksList2: $coordinator.tasksList2)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .chooseType:
                BranchChooseTaskTypeView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .article:
                BranchTaskTypeArticleEditorView(tasksList1: $coordinator.tasksList1, tasksList2: $coordinator.tasksList2)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            default:
                EmptyView()
            }
            
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 13)
                .fill(Color.white)
        }
        .overlay{
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.yellow, lineWidth: 7)
                .padding(5)
            
        }
        .shadow(radius: 30)
        .environmentObject(coordinator)
    }
}
#Preview {
    BranchCoordinatorView()
}
