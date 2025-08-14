//
//  ChooseTaskTypeCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import SwiftUI

struct ChooseTaskTypeCoordinatorView: View {
    @ObservedObject var coordinator = ChooseTaskTypeCoordinator()
    @State private var showSheet = false
    
    var body: some View {
        ZStack {
            Color.clear
            
            // Plus button in bottom right
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            sheetContent
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .environmentObject(coordinator)
    }
    
    private var sheetContent: some View {
        Group {
            switch coordinator.currentRoute {
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
            case .branch:
                BranchCoordinatorView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            default:
                EmptyView()
            }
        }
        .padding()
    }
}

#Preview {
    ChooseTaskTypeCoordinatorView()
}
