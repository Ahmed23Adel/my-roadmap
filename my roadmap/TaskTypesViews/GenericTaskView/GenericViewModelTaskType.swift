//
//  ViewModelTaskTypeBook.swift
//  my roadmap
//
//  Created by ahmed on 31/07/2025.
//

import Foundation
import Combine

class GenericViewModelTaskType: ObservableObject{
    @Published var taskBook: TaskObject
    
    init(taskBook: TaskObject){
        self.taskBook = taskBook
    }
    
    func setTask(taskBook: TaskBook){
        self.taskBook = taskBook
    }
    
    func getProgressFraction() -> Float {
        return Float(taskBook.progress)/100
    }
    
}
