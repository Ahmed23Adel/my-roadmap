//
//  MainHomeTaskGoalEditor.swift
//  my roadmap
//
//  Created by ahmed on 15/08/2025.
//

import SwiftUI

struct MainHomeTaskGoalEditor: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskGoal: TaskGoal
    
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
                
                // MARK: Goal Details
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
                
                // MARK: Dates
                VStack(alignment: .leading, spacing: 8) {
                    if taskGoal.taskStatus != .notStarted {
                        HStack {
                            Label("Start Date", systemImage: "calendar")
                            Spacer()
                            if let startDate = taskGoal.startDate {
                                Text(startDate, style: .date)
                            }
                        }
                    }
                    
                    if taskGoal.taskStatus == .completed {
                        HStack {
                            Label("Completed At", systemImage: "checkmark.circle")
                            Spacer()
                            if let completedAt = taskGoal.completedAt {
                                Text(completedAt, style: .date)
                            }
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
                        if let expectedStartDate = taskGoal.expectedStartDate {
                            Text(expectedStartDate, style: .date)
                        }
                    }
                    HStack {
                        Label("Deadline", systemImage: "clock.fill")
                        Spacer()
                        if let expectedDeadline = taskGoal.expectedDeadline {
                            Text(expectedDeadline, style: .date)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // MARK: Action Buttons
                if taskGoal.taskStatus == .notStarted {
                    Button("Start") {
                        // start logic
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                }
                
                if taskGoal.taskStatus == .inProgress {
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
        switch taskGoal.taskStatus {
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
    PreviewContentMainHomeTaskGoalEditor()
}

struct PreviewContentMainHomeTaskGoalEditor: View {
    var body: some View {
        do {
            var pastDate: Date {
                Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            var futureDate: Date {
                Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskGoal = try TaskGoal.createInProgressGoal(
                details: "Complete a comprehensive iOS development course covering SwiftUI, Core Data, and networking. Build at least 3 practice apps to solidify understanding of key concepts.",
                imageLink: "",
                title: "Learn iOS Development", progress: 30,
                expectedStartDate: pastDate,
                startDate: pastDate,
                expectedDeadline: futureDate,
                taskStatus: .inProgress
            )
            
            return AnyView(MainHomeTaskGoalEditor(roadmap: Roadmap(), taskGoal: taskGoal))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
