//
//  InProgressTaskArticleView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct InProgressTaskArticleView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskArticle: TaskArticle
    
    @StateObject private var viewModel: InProgressTaskArticleViewModel
    
    init(roadmap: Roadmap, taskArticle: TaskArticle){
        self.roadmap = roadmap
        self.taskArticle = taskArticle
        self._viewModel = StateObject(wrappedValue: InProgressTaskArticleViewModel(roadmap: roadmap, taskArticle: taskArticle))
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                // Status Header
                HStack {
                    Text("Task Status")
                        .font(.headline)
                    Spacer()
                    Text("In Progress")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Article Info
                TaskArticleInfoSection(taskArticle: taskArticle)
                
                
                // Active Dates
                VStack(alignment: .leading, spacing: 8) {
                    if let startDate = taskArticle.startDate {
                        HStack {
                            Label("Started On", systemImage: "play.circle")
                            Spacer()
                            Text(startDate, style: .date)
                        }
                    }
                    
                    HStack {
                        Label("Deadline", systemImage: "clock.fill")
                        Spacer()
                        Text(taskArticle.expectedDeadline!, style: .date)
                            .foregroundColor(isOverdue ? .red : .primary)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Complete Button
                Button("Complete Task") {
                    viewModel.completeTask()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("In Progress")
    }
    
    private var isOverdue: Bool {
        guard let deadline = taskArticle.expectedDeadline else { return false }
        return Date() > deadline
    }
    
    
}



#Preview {
    PreviewContentInProgressTaskArticleView()
}

struct PreviewContentInProgressTaskArticleView: View {
    var body: some View {
        do {
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskArticle = try TaskArticle.createInProgressArticle(
                articleName: "How to learn iOS",
                linkToArticle: "https://google.com",
                title: "Learn this",
                progress: 30,
                expectedStartDate: pastDate,
                startDate: pastDate,
                expectedDeadline: futureDate,
                taskStatus: .inProgress)
            
            
            let roadmap = Roadmap()
            roadmap.append(taskArticle)
            return AnyView(MainHomeTaskArticleEditor(roadmap: roadmap , taskArticle: taskArticle))
        } catch {
            return AnyView(Text("Preview Error: \(error)")
                .foregroundColor(.red))
        }
    }
}


