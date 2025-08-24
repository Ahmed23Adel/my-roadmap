//
//  BranchCoordinatorView.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import SwiftUI


struct BranchCoordinatorView: View {
    @ObservedObject var coordinator = BranchCoordinator()
    var showSheetFn: (TaskObject) -> Void
    var body: some View {
        Group{
            switch coordinator.currentRoute { //START: switch
            case .taskTypeBranch:
                TaskTypeBranchEditorView(tasksList1: $coordinator.tasksList1, tasksList2: $coordinator.tasksList2, showSheetFn: showSheetFn )
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
            case .book:
                BranchTaskTypeBookEditorView(tasksList1: $coordinator.tasksList1, tasksList2: $coordinator.tasksList2)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .youtubPlaylist:
                BranchTaskTypeYoutubeEditorView(tasksList1: $coordinator.tasksList1, tasksList2: $coordinator.tasksList2)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .goal:
                BranchTaskTypeGoalEditorView(tasksList1: $coordinator.tasksList1, tasksList2: $coordinator.tasksList2)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            default:
                EmptyView()
            }
            
        }
        .padding()
        
        .environmentObject(coordinator)
    }
}
#Preview {
    let anyFunc = { (_: TaskObject) in }
    BranchCoordinatorView(showSheetFn: anyFunc )
}
