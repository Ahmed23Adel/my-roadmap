//
//  TaskBookViewModel.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import Foundation
import Combine

class TaskBookViewModel: ObservableObject, GenericTaskType{    
    @Published var taskBook: TaskBook
    
    init(taskBook: TaskBook){
        self.taskBook = taskBook
    }
    
    func getLabel() -> String {
        taskBook.bookName
    }
    
    func getImgName() -> String {
        "book"
    }
}
