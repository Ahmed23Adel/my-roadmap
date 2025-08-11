//
//  TaskTypeContainerView.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import SwiftUI

struct BranchTaskTypeContainerView: View {
    @EnvironmentObject var coordinator: BranchCoordinator
    // by default if it's private var then the init is private
    @ObservedObject var taskContainer: TaskTypeContainer
    var body: some View {
        VStack{
            Image(taskContainer.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            Text(taskContainer.typeName)
        }
        .padding(15)
        .onTapGesture {
            coordinator.navigateToAdapted(taskContainer.route)
        }
    }
}

#Preview {
    let taskContainer = TaskTypeContainer(typeName: "book", iconName: "book", route: .book)
    TaskTypeContainerView(taskContainer: taskContainer)
}
