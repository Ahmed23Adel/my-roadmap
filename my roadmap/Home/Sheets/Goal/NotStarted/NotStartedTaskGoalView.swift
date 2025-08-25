//
//  NotStartedTaskGoalView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct NotStartedTaskGoalView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskGoal: TaskGoal
    @StateObject private var viewModel: NotStartedTaskGoalViewModel
    
    init(roadmap: Roadmap, taskGoal: TaskGoal) {
        self.roadmap = roadmap
        self.taskGoal = taskGoal
        self._viewModel = StateObject(wrappedValue: NotStartedTaskGoalViewModel(roadmap: roadmap, taskGoal: taskGoal))
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
                
                // Goal Details
                VStack(alignment: .leading, spacing: 8) {
                    Label("Goal Details", systemImage: "target")
                        .font(.title3)
                    
                    Text(taskGoal.details)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Expected Dates
                VStack(spacing: 8) {
                    HStack {
                        Label("Expected Start", systemImage: "calendar.badge.clock")
                        Spacer()
                        if let expectedStartDate = taskGoal.expectedStartDate {
                            Text(expectedStartDate, style: .date)
                        }
                    }
                    
                    HStack {
                        Label("Expected Deadline", systemImage: "clock.fill")
                        Spacer()
                        if let expectedDeadline = taskGoal.expectedDeadline {
                            Text(expectedDeadline, style: .date)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Action Buttons
                VStack(spacing: 12) {
                    Button("Goal reached") {
                        viewModel.startAndCompleteTask()
                    }
                    .buttonStyle(.bordered)
                    
                    
                }
                .padding(.top)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Goal Task")
    }
}

#Preview {
    PreviewContentNotStartedTaskGoalView()
}

struct PreviewContentNotStartedTaskGoalView: View {
    var body: some View {
        do {
            var pastDate: Date {
                Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            var futureDate: Date {
                Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskGoal = try TaskGoal.createNotStartedGoal(details: "any d", imageLink: nil, title: "any", expectedStartDate: futureDate, expectedDeadline: futureDate)
            
            let roadmap = Roadmap()
            roadmap.append(taskGoal)
            return AnyView(NotStartedTaskGoalView(roadmap: roadmap, taskGoal: taskGoal))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
