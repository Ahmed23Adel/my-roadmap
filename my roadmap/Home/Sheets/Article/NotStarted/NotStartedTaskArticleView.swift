//
//  NotStartedTaskArticleView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct NotStartedTaskArticleView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskArticle: TaskArticle
    
    @StateObject private var viewModel: NotStartedTaskArticleViewModel
    
    init(roadmap: Roadmap, taskArticle: TaskArticle){
        self.roadmap = roadmap
        self.taskArticle = taskArticle
        self._viewModel = StateObject(wrappedValue: NotStartedTaskArticleViewModel(roadmap: roadmap, taskArticle: taskArticle))
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                // Status Header
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
                
                // Article Info
                TaskArticleInfoSection(taskArticle: taskArticle)
                
                // Expected Dates
                ExpectedDatesSection(taskArticle: taskArticle)
                
                if viewModel.isPrevTaskCompleted(){
                    Group{
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
                        
                        // Start Button
                        Button("Start Task") {
                            viewModel.start()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.top)
                    }
                } else {
                    Group{
                        Text("Please finish previous tasks to start shis one")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                
                                
            }
            .padding()
        }
        .navigationTitle("Not Started")
    }
}


#Preview {
    PreviewContentNotStartedTaskArticleView()
}

struct PreviewContentNotStartedTaskArticleView: View {
    var body: some View {
        do {
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskArticle = try TaskArticle.createNotStartedArticle(
                articleName: "How to learn iOS",
                linkToArticle: "https://google.com",
                title: "Learn this",
                expectedStartDate: pastDate,
                expectedDeadline: futureDate)
            let roadmap = Roadmap()
            roadmap.append(taskArticle)
            return AnyView(MainHomeTaskArticleEditor(roadmap: roadmap , taskArticle: taskArticle))
        } catch {
            return AnyView(Text("Preview Error: \(error)")
                .foregroundColor(.red))
        }
    }
}

