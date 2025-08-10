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
                TaskTypeBookEditorView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .youtubPlaylist:
                TaskTypeYoutubeEditorView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .article:
                TaskTypeArticleEditorView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .goal:
                TaskTypeGoalEditorView()
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
    ChooseTaskTypeCoordinatorView()
}
