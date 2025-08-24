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
    @State private var pagesToAdd: Int = 0
    
    var body: some View {
        VStack { // START: main VStack
            Group { // START: Group for status
                HStack { // START: Status HStack
                    Text("Task Status: ")
                        .font(.title)
                    Spacer()
                    if taskBook.taskStatus == .notStarted {
                        Text("Not started")
                            .foregroundColor(.red)
                            .font(.title)
                        Image("notstarted")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    } else if taskBook.taskStatus == .inProgress {
                        Text("In progress")
                            .foregroundColor(.yellow)
                            .font(.title)
                        Image("inprogress")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    } else if taskBook.taskStatus == .completed {
                        Text("Completed")
                            .foregroundColor(.green)
                            .font(.title)
                        Image("completedchecked")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    } // END: Status if-else
                } // END: Status HStack
                .padding()
            } // END: Group for status
            
            Group { // START: Group for book name and pages
                HStack {
                    Text("Book Name: ")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.bookName)
                        .font(.title2)
                } // END: Book name HStack
                
                HStack {
                    Text("Total Pages: ")
                        .font(.title2)
                    Spacer()
                    Text("\(taskBook.numPagesInBook)")
                        .font(.title2)
                } // END: Total pages HStack
                
                VStack { // START: Pages read VStack
                    HStack {
                        Text("Pages Read: ")
                            .font(.title2)
                        Spacer()
                        Text("\(taskBook.numPagesRead)")
                            .font(.title2)
                    } // END: Pages read display HStack
                    
                    HStack {
                        Text("Add pages:")
                            .font(.subheadline)
                        
                        HStack {
                            Button {
                                if pagesToAdd > 0 {
                                    pagesToAdd -= 1
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .foregroundColor(.blue)
                            }
                            
                            TextField("0", value: $pagesToAdd, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 60)
                                .multilineTextAlignment(.center)
                            
                            Button {
                                pagesToAdd += 1
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.blue)
                            }
                        } // END: Stepper-like HStack
                        
                        Button("Update") {
//                            taskBook.numPagesRead = min(taskBook.numPagesRead + pagesToAdd, taskBook.numPagesInBook)
                            pagesToAdd = 0
                        }
                        .buttonStyle(.bordered)
                        .disabled(pagesToAdd <= 0)
                    } // END: Add pages control HStack
                } // END: Pages read VStack
                
                HStack {
                    Text("Reading Progress: ")
                        .font(.title2)
                    Spacer()
                    Text("\(Int((Double(taskBook.numPagesRead) / Double(taskBook.numPagesInBook)) * 100))%")
                        .font(.title2)
                        .foregroundColor(.blue)
                } // END: Reading progress HStack
            } // END: Group for book name and pages
            .padding()
            
            Group { // START: Group for dates based on status
                if taskBook.taskStatus != .notStarted {
                    HStack {
                        Text("Start date")
                            .font(.title2)
                        Spacer()
                        Text(taskBook.startDate!, style: .date)
                            .font(.title2)
                    } // END: Start date HStack
                }
                
                if taskBook.taskStatus == .completed {
                    HStack {
                        Text("Completed at: ")
                            .font(.title2)
                        Spacer()
                        Text(taskBook.completedAt!, style: .date)
                            .font(.title2)
                    } // END: Completed date HStack
                }
            } // END: Group for dates based on status
            .padding()
            
            Group { // START: Group for expected dates
                HStack {
                    Text("Expected start date ")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.expectedStartDate!, style: .date)
                        .font(.title2)
                } // END: Expected start date HStack
                
                HStack {
                    Text("Expected deadline ")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.expectedDeadline!, style: .date)
                        .font(.title2)
                } // END: Expected deadline HStack
            } // END: Group for expected dates
            .padding()
            
            if taskBook.taskStatus == .notStarted {
                Button("Start") {
                    // TODO: Start logic
                }
                .buttonStyle(.borderedProminent)
            }
            
            if taskBook.taskStatus == .inProgress {
                Button("End") {
                    // TODO: End logic
                }
                .buttonStyle(.borderedProminent)
            }
        } // END: main VStack
    } // END: body
} // END: MainHomeTaskBookEditor struct

#Preview {
    PreviewContentMainHomeTaskBookEditor()
} // END: Preview

struct PreviewContentMainHomeTaskBookEditor: View {
    var body: some View {
        do {
            let currentDate = Date()
            let pastDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            let futureDate = Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            
            let taskBook = try TaskBook.createInProgressBook(
                bookName: "Clean Code",
                numPagesInBook: 300,
                numPagesRead: 50,
                title: "Read book",
                progress: 50,
                expectedStartDate: pastDate,
                startDate: pastDate,
                expectedDeadline: futureDate,
                taskStatus: .inProgress
            )
            
            return AnyView(MainHomeTaskBookEditor(roadmap: Roadmap(), taskBook: taskBook))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    } // END: body
} // END: PreviewContentMainHomeTaskBookEditor struct
