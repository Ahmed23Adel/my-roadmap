//
//  TaskTypeBranchEditorView.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import SwiftUI

struct TaskTypeBranchEditorView: View {
    @EnvironmentObject private var mainCoordinator: AddNewRoadmapCoordinator
    @EnvironmentObject var branchCoordinator: BranchCoordinator
    @EnvironmentObject private var choseTaskType: ChooseTaskTypeCoordinator
    
    
    @Binding var tasksList1: ListOfTasks
    @Binding var tasksList2: ListOfTasks
    
    @StateObject private var viewModel = TaskTypeBranchEditorViewModel()
    
    var showSheetFn: (TaskObject) -> Void
    
    var body: some View {
        VStack{ // START outer VSTACK
            HStack{ // START HStack
                VStack{ // START  VStack
                    ScrollView(.vertical){
                        ForEach(tasksList1, id: \.self) { singleTask in
                            DrawableSingleTask(singleTask: singleTask, showSheetFn: showSheetFn)
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
                            DrawableSingleTask(singleTask: singleTask, showSheetFn: showSheetFn)
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
            viewModel.setMainCoordinator(coordinator: mainCoordinator)
        }
        .alert(isPresented: $viewModel.showError){
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMsg),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
}

#Preview {
    @State var tasksList1 = ListOfTasks(title: "")
    @State var tasksList2 = ListOfTasks(title: "")
    let anyFunc = { (_: TaskObject) in }
    TaskTypeBranchEditorView(tasksList1: $tasksList1, tasksList2: $tasksList2, showSheetFn: anyFunc)
}
