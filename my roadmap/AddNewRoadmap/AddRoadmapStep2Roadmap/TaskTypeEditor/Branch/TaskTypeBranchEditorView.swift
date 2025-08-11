//
//  TaskTypeBranchEditorView.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import SwiftUI

struct TaskTypeBranchEditorView: View {
    @EnvironmentObject var branchCoordinator: BranchCoordinator
    @EnvironmentObject private var choseTaskType: ChooseTaskTypeCoordinator
    
    @Binding var tasksList1: ListOfTasks
    @Binding var tasksList2: ListOfTasks
    
    @StateObject private var viewModel = TaskTypeBranchEditorViewModel()
    var body: some View {
        VStack{ // START outer VSTACK
            HStack{ // START HStack
                VStack{ // START  VStack
                    ScrollView(.vertical){
                        ForEach(tasksList1, id: \.self) { singleTask in
                            DrawableSingleTask(singleTask: singleTask)
                                .scaleEffect(0.5)
                        }
                    }
                    FixedStyleButtonViewGeneric(isDisabled: viewModel.isDisabled(), title: "Add new Task"){
                        viewModel.addNewTaskList1()
                    }
                } // END  VStack
                
                Divider()
                    
                VStack{ // START  VStack
                    ScrollView(.vertical){
                        ForEach(tasksList2, id: \.self) { singleTask in
                            DrawableSingleTask(singleTask: singleTask)
                                .scaleEffect(0.5)
                        }
                    }
                    FixedStyleButtonViewGeneric(isDisabled: viewModel.isDisabled(), title: "Add new Task"){
                        viewModel.addNewTaskList2()
                    }
                } // END  VStack
                
            } // END HStack
            
            HStack{
                
                Button("Submit"){
                    viewModel.addTask()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isDisabledGlobal())
                .frame(width: 150, height: 60)
                .controlSize(.large)
                .tint(Color.green)
                
                Button("Cancel", role: .destructive){
                    viewModel.cancel()
                }
                .buttonStyle(.borderedProminent)
                .frame(width: 150, height: 60)
                .controlSize(.large)
            }
            
            
        } // END outer VSTACK
        .onAppear{
            viewModel.setChooseTaskTypeCoordinator(coordinator: choseTaskType)
            viewModel.setBranchCoordinator(coordinator: branchCoordinator)
        }
    }
}

#Preview {
    @State var tasksList1 = ListOfTasks(title: "")
    @State var tasksList2 = ListOfTasks(title: "")
    
    TaskTypeBranchEditorView(tasksList1: $tasksList1, tasksList2: $tasksList2)
}
