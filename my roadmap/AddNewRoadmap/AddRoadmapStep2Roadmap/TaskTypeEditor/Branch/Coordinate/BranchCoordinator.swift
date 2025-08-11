//
//  BranchCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import Foundation
import Combine


class BranchCoordinator: ObservableObject{
    @Published var currentRoute: BranchRoute = .taskTypeBranch
    // centralized place to put into list of tasks
    // when it was in teh viewmodel of `TaskTypeBranchEditorView`
    // the viewmodel was destructed each time it was redrawn
    // so each time i create object of BranchChooseTaskTypeView it create new viewmodel with new list
    @Published var tasksList1 = ListOfTasks(title: "")
    @Published var tasksList2 = ListOfTasks(title: "")
    var list1Index = 1
    var list2Index = 2
    @Published var currentListIndex: Int? = nil
    
    func navigateTo(_ route: BranchRoute){
        self.currentRoute = route
    }
    
    func navigateToAdapted(_ route: ChooseTaskTypeRoute){
        switch route{
        case .article:
            navigateTo(.article)
        case .book:
            navigateTo(.book)
        case .course:
            navigateTo(.course)
        case .goal:
            navigateTo(.goal)
        default:
            print("")
        }
    }
    
    
    
}
