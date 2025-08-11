//
//  ChooseTaskTypeViewModel.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import Foundation
import Combine



class BranchChooseTaskTypeViewModel: ObservableObject{
    @Published var allTaskTypes: [TaskTypeContainer] = []
    
    init(){
        initAllTaskTypes()
    }
    
    private func initAllTaskTypes(){
        allTaskTypes.append(TaskTypeContainer(typeName: "Book", iconName: "book", route: .book))
        allTaskTypes.append(TaskTypeContainer(typeName: "Article", iconName: "article", route: .article))
        allTaskTypes.append(TaskTypeContainer(typeName: "Youtube playlist", iconName: "youtube", route: .youtubPlaylist))
        allTaskTypes.append(TaskTypeContainer(typeName: "Goal", iconName: "goal", route: .goal))
        
    }
}
