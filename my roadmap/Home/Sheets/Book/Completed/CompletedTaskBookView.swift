//
//  CompletedTaskBookView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct CompletedTaskBookView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskBook: TaskBook
    @StateObject private var viewModel: CompletedTaskBookViewModel
    
    init(roadmap: Roadmap, taskBook: TaskBook) {
        self.roadmap = roadmap
        self.taskBook = taskBook
        self._viewModel = StateObject(wrappedValue: CompletedTaskBookViewModel(roadmap: roadmap, taskBook: taskBook))
    }
    
    var body: some View {
        VStack {
            // Status Section
            HStack {
                Text("Task Status: ")
                    .font(.title)
                Spacer()
                Text("Completed")
                    .foregroundColor(.green)
                    .font(.title)
                Image("completedchecked")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            .padding()
            
            // Book Information Section
            VStack {
                HStack {
                    Text("Book Name: ")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.bookName)
                        .font(.title2)
                }
                
                HStack {
                    Text("Total Pages: ")
                        .font(.title2)
                    Spacer()
                    Text("\(taskBook.numPagesInBook)")
                        .font(.title2)
                }
                
                HStack {
                    Text("Pages Read: ")
                        .font(.title2)
                    Spacer()
                    Text("\(taskBook.numPagesRead)")
                        .font(.title2)
                }
                
                HStack {
                    Text("Reading Progress: ")
                        .font(.title2)
                    Spacer()
                    Text("100%")
                        .font(.title2)
                        .foregroundColor(.green)
                }
            }
            .padding()
            
            // Dates Section
            VStack {
                HStack {
                    Text("Start date")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.startDate!, style: .date)
                        .font(.title2)
                }
                
                HStack {
                    Text("Completed at: ")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.completedAt!, style: .date)
                        .font(.title2)
                }
                
                HStack {
                    Text("Expected deadline ")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.expectedDeadline!, style: .date)
                        .font(.title2)
                }
            }
            .padding()
            
            // Completion Summary
            if let completionSummary = viewModel.completionSummary {
                VStack {
                    Text("Completion Summary")
                        .font(.headline)
                        .padding(.top)
                    
                    Text(completionSummary)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            
            Spacer()
        }
    }
}

//#Preview {
//    CompletedTaskBookView()
//}
