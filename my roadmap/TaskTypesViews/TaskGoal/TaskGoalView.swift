//
//  TaskGoalView.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import SwiftUI

struct TaskGoalView: View {
    var taskGoal: TaskGoal
    @StateObject var viewModel: TaskGoalViewModel
    
    init(taskGoal: TaskGoal) {
        self.taskGoal = taskGoal
        self._viewModel = StateObject(wrappedValue: TaskGoalViewModel(taskGoal: taskGoal))
        
    }
    
    var body: some View {
        GenericViewTaskType(taskBook: viewModel.taskGoal, Tasklabel: viewModel.getLabel(), imgName: viewModel.getImgName())
    }
}

#Preview {
    PreviewContentTaskGoal()
}

struct PreviewContentTaskGoal: View {
    var body: some View {
        do {
            var currentDate: Date {
                return Date()
            }
            
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            let startDate = pastDate
            let taskGoal = try TaskGoal.createInProgressGoal(details: "any", imageLink: "", title: "finished", progress: 10, expectedStartDate: pastDate, startDate: pastDate, expectedDeadline: futureDate, taskStatus: .inProgress)
            
            
                
            return AnyView(TaskGoalView(taskGoal: taskGoal))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
