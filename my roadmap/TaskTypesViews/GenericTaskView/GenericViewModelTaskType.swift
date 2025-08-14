//
//  ViewModelTaskTypeBook.swift
//  my roadmap
//
//  Created by ahmed on 31/07/2025.
//

import Foundation
import Combine

class GenericViewModelTaskType: ObservableObject{
    @Published var singleTask: TaskObject
    
    init(singleTask: TaskObject){
        self.singleTask = singleTask
    }
    
    func setTask(singleTask: TaskBook){
        self.singleTask = singleTask
    }
    
    func getProgressFraction() -> Float {
        return Float(singleTask.progress)/100
    }
    
}
