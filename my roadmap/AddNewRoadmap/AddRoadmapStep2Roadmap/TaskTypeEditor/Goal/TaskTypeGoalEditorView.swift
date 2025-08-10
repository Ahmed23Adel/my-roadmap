//
//  TaskTypeGoalEditorView.swift
//  my roadmap
//
//  Created by ahmed on 10/08/2025.
//

import SwiftUI

struct TaskTypeGoalEditorView: View {
    @EnvironmentObject private var mainCoordinator: AddNewRoadmapCoordinator
    @EnvironmentObject private var subCoordinator: ChooseTaskTypeCoordinator
    
    @StateObject var viewModel = TaskTypeGoalEditorViewModel()
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
                        TextField("Details",  text: $viewModel.details)
                            .font(.system(size: 20))
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
                viewModel.setSubCoordinator(coordinator: subCoordinator)
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
    TaskTypeGoalEditorView()
}
