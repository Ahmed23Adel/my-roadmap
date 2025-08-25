//
//  CompletedTaskGoalView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct CompletedTaskGoalView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskGoal: TaskGoal
    @StateObject private var viewModel: CompletedTaskGoalViewModel
    
    init(roadmap: Roadmap, taskGoal: TaskGoal) {
        self.roadmap = roadmap
        self.taskGoal = taskGoal
        self._viewModel = StateObject(wrappedValue: CompletedTaskGoalViewModel(roadmap: roadmap, taskGoal: taskGoal))
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
                    
                    Text("Goal Completed!")
                        .font(.title2.bold())
                        .foregroundColor(.green)
                    
                    Text("Congratulations on achieving your goal!")
                        .font(.body)
                        .foregroundColor(.secondary)
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
                
                // Completion Summary
                VStack(alignment: .leading, spacing: 8) {
                    Label("Task Summary", systemImage: "list.clipboard")
                        .font(.title3)
                    
                    if let startDate = taskGoal.startDate,
                       let completedAt = taskGoal.completedAt {
                        
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
                
                // Expected vs Actual Timeline
                VStack(alignment: .leading, spacing: 8) {
                    Label("Timeline Comparison", systemImage: "calendar.badge.clock")
                        .font(.title3)
                    
                    if let expectedStartDate = taskGoal.expectedStartDate {
                        HStack {
                            Label("Expected Start", systemImage: "calendar")
                            Spacer()
                            Text(expectedStartDate, style: .date)
                        }
                    }
                    
                    if let expectedDeadline = taskGoal.expectedDeadline {
                        HStack {
                            Label("Expected Deadline", systemImage: "clock.fill")
                            Spacer()
                            Text(expectedDeadline, style: .date)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
            }
            .padding()
        }
        .navigationTitle("Completed Goal")
    }
    
    private var durationText: String {
        guard let startDate = taskGoal.startDate,
              let completedAt = taskGoal.completedAt else {
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
        guard let completedAt = taskGoal.completedAt,
              let deadline = taskGoal.expectedDeadline else {
            return false
        }
        return completedAt <= deadline
    }
}

#Preview {
    PreviewContentCompletedTaskGoalView()
}

struct PreviewContentCompletedTaskGoalView: View {
    var body: some View {
        do {
            var pastDate: Date {
                Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            var futureDate: Date {
                Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskGoal = try TaskGoal.createCompletedGoal(
                details: "Complete a comprehensive iOS development course covering SwiftUI, Core Data, and networking. Build at least 3 practice apps to solidify understanding of key concepts.",
                imageLink: "",
                title: "Learn iOS Development",
                expectedStartDate: pastDate,
                startDate: pastDate,
                completedAt: Date(),
                expectedDeadline: futureDate
            )
            
            let roadmap = Roadmap()
            roadmap.append(taskGoal)
            return AnyView(CompletedTaskGoalView(roadmap: roadmap, taskGoal: taskGoal))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
