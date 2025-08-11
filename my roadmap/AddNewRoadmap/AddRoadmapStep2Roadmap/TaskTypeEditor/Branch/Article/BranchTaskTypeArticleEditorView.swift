//
//  TaskTypeArticleEditorView.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import SwiftUI

struct BranchTaskTypeArticleEditorView: View {
    @EnvironmentObject private var mainCoordinator: AddNewRoadmapCoordinator
    @EnvironmentObject private var branchCoordinator: BranchCoordinator
    
    @Binding var tasksList1:ListOfTasks
    @Binding var tasksList2:ListOfTasks
    
    @StateObject var viewModel = BranchTaskTypeArticleEditorViewModel()
    
    var body: some View {
            ScrollView(.vertical){ //START: ScrollView
                VStack{  //START: ZStack
                    Group{
                        TextField("Task title",  text: $viewModel.taskTitle)
                            .font(.system(size: 20))
                            .mandatoryField()
                            .padding()
                    }
                    .padding()
                    Group{
                        TextField("Article name",  text: $viewModel.articleName)
                            .font(.system(size: 20))
                            .mandatoryField()
                            .padding()
                        
                        TextField("Link to Article",  text: $viewModel.linkToArticle)
                            .font(.system(size: 20))
                            .keyboardType(.numberPad)
                            .mandatoryField()
                            .padding()
                        
                    }
                    .padding()
                    Group{
                        DatePicker("Expected start date", selection: $viewModel.expectedStartDate)
                            .padding()
                        DatePicker("Expected End date", selection: $viewModel.expectedStartDate)
                            .padding()
                    }
                    .padding()
                    
                    FixedStyleButtonView(isDisabled: !viewModel.isFormValid()){
                        viewModel.addTask()
                        
                    }
                } // END: VStack
                .padding()
            } //END: ScrollView
            .onAppear{
                viewModel.setMainCoordinator(coordinator: mainCoordinator)
                viewModel.setBranchCoordinator(coordinator: branchCoordinator)
                viewModel.setTasksLists(tasksList1: tasksList1, tasksList2: tasksList2)
            }
            .alert(isPresented: $viewModel.showError) { // start alert
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMsg),
                    dismissButton: .default(Text("Ok"))
                )

            } // END alert
    }
}

#Preview {
    @State var tasksList1 = ListOfTasks(title: "")
    @State var tasksList2 = ListOfTasks(title: "")
    
    BranchTaskTypeArticleEditorView(tasksList1: $tasksList1, tasksList2: $tasksList2)
}
