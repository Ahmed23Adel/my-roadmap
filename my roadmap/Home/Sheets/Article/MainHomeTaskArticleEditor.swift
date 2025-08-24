//
//  MainHomeTaskArticleEditor.swift
//  my roadmap
//
//  Created by ahmed on 15/08/2025.
//

import SwiftUI

struct MainHomeTaskArticleEditor: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskArticle: TaskArticle
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                // MARK: Task Status
                HStack {
                    Text("Task Status")
                        .font(.headline)
                    Spacer()
                    statusLabel
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // MARK: Article Info
                VStack(alignment: .leading, spacing: 8) {
                    Label(taskArticle.articleName, systemImage: "doc.text")
                        .font(.title3)
                    
                    Button {
                        if let url = URL(string: taskArticle.linkToArticle) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Label("Open Article", systemImage: "arrow.up.right.square")
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // MARK: Dates
                VStack(alignment: .leading, spacing: 8) {
                    if taskArticle.taskStatus != .notStarted {
                        HStack {
                            Label("Start Date", systemImage: "calendar")
                            Spacer()
                            Text(taskArticle.startDate!, style: .date)
                        }
                    }
                    
                    if taskArticle.taskStatus == .completed {
                        HStack {
                            Label("Completed At", systemImage: "checkmark.circle")
                            Spacer()
                            Text(taskArticle.completedAt!, style: .date)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // MARK: Expected Dates
                VStack(spacing: 8) {
                    HStack {
                        Label("Expected Start", systemImage: "calendar.badge.clock")
                        Spacer()
                        Text(taskArticle.expectedStartDate!, style: .date)
                    }
                    HStack {
                        Label("Deadline", systemImage: "clock.fill")
                        Spacer()
                        Text(taskArticle.expectedDeadline!, style: .date)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // MARK: Action Buttons
                if taskArticle.taskStatus == .notStarted {
                    Button("Start") {
                        // start logic
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                }
                
                if taskArticle.taskStatus == .inProgress {
                    Button("End") {
                        // end logic
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                }
            }
            .padding()
        }
    }
    
    // MARK: Status Label View
    private var statusLabel: some View {
        switch taskArticle.taskStatus {
        case .notStarted:
            return Text("Not Started")
                .font(.subheadline.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.red)
                .cornerRadius(12)
        case .inProgress:
            return Text("In Progress")
                .font(.subheadline.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.yellow)
                .cornerRadius(12)
        case .completed:
            return Text("Completed")
                .font(.subheadline.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.green)
                .cornerRadius(12)
        }
    }
}

#Preview {
    PreviewContentMainHomeTaskArticleEditor()
}

struct PreviewContentMainHomeTaskArticleEditor: View {
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
                progress: 20,
                expectedStartDate: pastDate,
                startDate: pastDate,
                expectedDeadline: futureDate,
                taskStatus: .inProgress,

            )
            
            return AnyView(MainHomeTaskArticleEditor(roadmap: Roadmap(), taskArticle: taskArticle))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
