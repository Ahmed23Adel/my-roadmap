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
        switch taskGoal.taskStatus {
        case .notStarted:
            NotStartedTaskGoalView(roadmap: roadmap, taskGoal: taskGoal)
        case .inProgress:
            CompletedTaskGoalView(roadmap: roadmap, taskGoal: taskGoal)
        case .completed:
            CompletedTaskGoalView(roadmap: roadmap, taskGoal: taskGoal)
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
