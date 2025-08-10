//
//  TaskTypeBookEditor.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import SwiftUI

struct TaskTypeBookEditorView: View {
    @EnvironmentObject private var mainCoordinator: AddNewRoadmapCoordinator
    @EnvironmentObject private var subCoordinator: ChooseTaskTypeCoordinator
    
    @StateObject var viewModel = TaskTypeBookEditorViewModel()
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
                        TextField("Book Name",  text: $viewModel.bookName)
                            .font(.system(size: 20))
                            .mandatoryField()
                            .padding()
                        
                        TextField("Number of pages in book",  text: $viewModel.numPagesInBook)
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
    TaskTypeBookEditorView()
}
