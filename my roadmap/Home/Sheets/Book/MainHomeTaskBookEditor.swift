//
//  MainHomeTaskBookEditor.swift
//  my roadmap
//
//  Created by ahmed on 15/08/2025.
//

import SwiftUI

struct MainHomeTaskBookEditor: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskBook: TaskBook
    
    var body: some View {
        switch taskBook.taskStatus {
        case .notStarted:
            NotStartedTaskBookView(roadmap: roadmap, taskBook: taskBook)
        case .inProgress:
            InProgressTaskBookView(roadmap: roadmap, taskBook: taskBook)
        case .completed:
            CompletedTaskBookView(roadmap: roadmap, taskBook: taskBook)
        }
    }
}
