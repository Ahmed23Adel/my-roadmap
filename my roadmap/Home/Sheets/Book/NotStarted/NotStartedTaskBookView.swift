//
//  NotStartedTaskBookView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct NotStartedTaskBookView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskBook: TaskBook
    
    @StateObject private var viewModel: NotStartedTaskBookViewModel
    
    init(roadmap: Roadmap, taskBook: TaskBook){
        self.roadmap = roadmap
        self.taskBook = taskBook
        self._viewModel = StateObject(wrappedValue: NotStartedTaskBookViewModel(roadmap: roadmap, taskBook: taskBook))
    }
    
    var body: some View {
        ScrollView{
            
            
            VStack { // START: main VStack
                Group { // START: Group for status
                    HStack {
                        Text("Task Status")
                            .font(.headline)
                        Spacer()
                        Text("Not Started")
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                } // END: Group for status
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Label(taskBook.bookName, systemImage: "doc.text")
                        .font(.title3)
                    
                    Label(String(taskBook.numPagesInBook) + " pages", systemImage: "number")
                        .font(.title3)
                    
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                
                VStack(spacing: 8) {
                    HStack {
                        Label("Expected Start", systemImage: "calendar.badge.clock")
                        Spacer()
                        Text(taskBook.expectedStartDate!, style: .date)
                    }
                    HStack {
                        Label("Deadline", systemImage: "clock.fill")
                        Spacer()
                        Text(taskBook.expectedDeadline!, style: .date)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                
                if viewModel.isPrevTaskCompleted() {
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Ready to Start", systemImage: "play.circle")
                                .font(.title3)
                                .foregroundColor(.blue)
                            
                            Text("Click the start button when you're ready to begin working on this task.")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                        
                        Button("Start Task") {
                            viewModel.startTask()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.top)
                    }
                } else {
                    VStack {
                        Text("Please finish previous tasks to start this one")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }

                
            } // END: main VStack
            .padding()
        }
    }
}




#Preview {
    PreviewContentNotStartedTaskBookView()
}

struct PreviewContentNotStartedTaskBookView: View {
    var body: some View {
        do {
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskBook = try TaskBook.createNotStartedBook(
                bookName: "Clean code",
                numPagesInBook: 100,
                title: "Read book",
                expectedStartDate: futureDate,
                expectedDeadline: futureDate)
            
            let roadmap = Roadmap()
            roadmap.append(taskBook)
            return AnyView(NotStartedTaskBookView(roadmap: roadmap , taskBook: taskBook))
        } catch {
            return AnyView(Text("Preview Error: \(error)")
                .foregroundColor(.red))
        }
    }
}

