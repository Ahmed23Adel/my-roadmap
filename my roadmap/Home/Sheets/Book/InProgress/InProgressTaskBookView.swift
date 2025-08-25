//
//  InProgressTaskBookView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

// MARK: - In Progress View
struct InProgressTaskBookView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskBook: TaskBook
    @StateObject private var viewModel: InProgressTaskBookViewModel
    
    init(roadmap: Roadmap, taskBook: TaskBook) {
        self.roadmap = roadmap
        self.taskBook = taskBook
        self._viewModel = StateObject(wrappedValue: InProgressTaskBookViewModel(roadmap: roadmap, taskBook: taskBook))
    }
    
    var body: some View {
        VStack {
            // Status Section
            HStack {
                Text("Task Status: ")
                    .font(.title)
                Spacer()
                Text("In progress")
                    .foregroundColor(.yellow)
                    .font(.title)
                Image("inprogress")
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
                
                VStack {
                    HStack {
                        Text("Pages Read: ")
                            .font(.title2)
                        Spacer()
                        Text("\(taskBook.numPagesRead)")
                            .font(.title2)
                    }
                    
                    // Page Update Controls
                    HStack {
                        Text("Add pages:")
                            .font(.subheadline)
                        
                        HStack {
                            Button {
                                viewModel.decrementPagesToAdd()
                            } label: {
                                Image(systemName: "minus")
                                    .foregroundColor(.blue)
                            }
                            
                            TextField("0", value: $viewModel.pagesToAdd, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 60)
                                .multilineTextAlignment(.center)
                            
                            Button {
                                viewModel.incrementPagesToAdd()
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        Button("Update") {
                            viewModel.updatePagesRead()
                        }
                        .buttonStyle(.bordered)
                        .disabled(viewModel.pagesToAdd <= 0)
                    }
                }
                
                HStack {
                    Text("Reading Progress: ")
                        .font(.title2)
                    Spacer()
                    Text("\(viewModel.readingProgress)%")
                        .font(.title2)
                        .foregroundColor(.blue)
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
                    Text("Expected deadline ")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.expectedDeadline!, style: .date)
                        .font(.title2)
                }
            }
            .padding()
            
            // Action Button
            Button("Complete") {
                viewModel.completeTask()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}


//#Preview {
//    InProgressTaskBookView()
//}
