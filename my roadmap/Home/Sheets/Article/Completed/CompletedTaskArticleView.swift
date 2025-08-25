//
//  CompletedTaskArticleView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct CompletedTaskArticleView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskArticle: TaskArticle
    
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
                TaskArticleInfoSection(taskArticle: taskArticle)
                
                // Completion Summary
                VStack(alignment: .leading, spacing: 8) {
                    Label("Task Summary", systemImage: "list.clipboard")
                        .font(.title3)
                    
                    if let startDate = taskArticle.startDate,
                       let completedAt = taskArticle.completedAt {
                        
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
                
                // Action Buttons
                VStack(spacing: 12) {
                    Button("View Article") {
                        if let url = URL(string: taskArticle.linkToArticle) {
                            UIApplication.shared.open(url)
                        }
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Completed")
    }
    
    private var durationText: String {
        guard let startDate = taskArticle.startDate,
              let completedAt = taskArticle.completedAt else {
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
        guard let completedAt = taskArticle.completedAt,
              let deadline = taskArticle.expectedDeadline else {
            return false
        }
        return completedAt <= deadline
    }
    
    
}


#Preview {
    PreviewContentCompletedTaskArticleView()
}

struct PreviewContentCompletedTaskArticleView: View {
    var body: some View {
        do {
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskArticle = try TaskArticle.createCompletedArticle(
                articleName: "How to learn iOS",
                linkToArticle: "https://google.com",
                title: "Learn this",
                expectedStartDate: pastDate,
                startDate: pastDate,
                completedAt: pastDate,
                expectedDeadline: pastDate)
            
           
            let roadmap = Roadmap()
            roadmap.append(taskArticle)
            return AnyView(MainHomeTaskArticleEditor(roadmap: roadmap , taskArticle: taskArticle))
        } catch {
            return AnyView(Text("Preview Error: \(error)")
                .foregroundColor(.red))
        }
    }
}


