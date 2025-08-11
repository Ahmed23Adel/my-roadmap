//
//  ChooseTaskType.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import SwiftUI



struct BranchChooseTaskTypeView: View {
    
    private var viewModel = BranchChooseTaskTypeViewModel()
    private var cols = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150))
    ]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: cols){
                ForEach(viewModel.allTaskTypes, id: \.id){ taskContainer in
                    BranchTaskTypeContainerView(taskContainer: taskContainer)
                }
            }
            .padding() 
        }
        
        
    }
}

#Preview {
    ChooseTaskTypeView()
}
