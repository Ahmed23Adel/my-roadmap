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
        ScrollView {
            VStack(spacing: 16) {
                
                // Status Header
                HStack {
                    Text("Task Status")
                        .font(.headline)
                    Spacer()
                    Text("Completed")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.green)
                        .cornerRadius(12)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Completion Celebration
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                    
                    Text("Task Completed!")
                        .font(.title2.bold())
                        .foregroundColor(.green)
                    
                    Text("Great job on finishing this task!")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Article Info
                VStack { // START VSTACK book_info
                    HStack { // START HSTACK book_name
                        Text("Book Name: ")
                            .font(.title2)
                        Spacer()
                        Text(taskBook.bookName)
                            .font(.title2)
                    } // END HSTACK book_name
                    
                    HStack { // START HSTACK total_pages
                        Text("Total Pages: ")
                            .font(.title2)
                        Spacer()
                        Text("\(taskBook.numPagesInBook)")
                            .font(.title2)
                    } // END HSTACK total_pages
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Completion Summary
                VStack(alignment: .leading, spacing: 8) {
                    Label("Task Summary", systemImage: "list.clipboard")
                        .font(.title3)
                    
                    if let startDate = taskBook.startDate,
                       let completedAt = taskBook.completedAt {
                        
                        HStack {
                            Label("Started", systemImage: "play.circle")
                            Spacer()
                            Text(startDate, style: .date)
                        }
                        
                        HStack {
                            Label("Completed", systemImage: "checkmark.circle")
                            Spacer()
                            Text(completedAt, style: .date)
                        }
                        
                        HStack {
                            Label("Duration", systemImage: "clock")
                            Spacer()
                            Text(durationText)
                        }
                        
                        HStack {
                            Label("On Time", systemImage: completedOnTime ? "checkmark.circle" : "xmark.circle")
                            Spacer()
                            Text(completedOnTime ? "Yes" : "No")
                                .foregroundColor(completedOnTime ? .green : .red)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                                
            }
            .padding()
        }
        .navigationTitle("Completed")
    }
    
    private var durationText: String {
        guard let startDate = taskBook.startDate,
              let completedAt = taskBook.completedAt else {
            return "Unknown"
        }
        
        let duration = Calendar.current.dateComponents([.day], from: startDate, to: completedAt)
        let days = duration.day ?? 0
        
        if days == 0 {
            return "Same day"
        } else if days == 1 {
            return "1 day"
        } else {
            return "\(days) days"
        }
    }
    
    private var completedOnTime: Bool {
        guard let completedAt = taskBook.completedAt,
              let deadline = taskBook.expectedDeadline else {
            return false
        }
        return completedAt <= deadline
    }
    
    
}


#Preview {
    PreviewContentCompletedTaskBookView()
}

struct PreviewContentCompletedTaskBookView: View {
    var body: some View {
        do {
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskBook = try TaskBook.createCompletedBook(
                bookName: "How to learn iOS",
                numPagesInBook: 30,
                numPagesRead: 3,
                title: "Learn this",
                expectedStartDate: pastDate,
                startDate: pastDate,
                completedAt: pastDate,
                expectedDeadline: pastDate)
            
            
           
            let roadmap = Roadmap()
            roadmap.append(taskBook)
            return AnyView(CompletedTaskBookView(roadmap: roadmap , taskBook: taskBook))
        } catch {
            return AnyView(Text("Preview Error: \(error)")
                .foregroundColor(.red))
        }
    }
}


