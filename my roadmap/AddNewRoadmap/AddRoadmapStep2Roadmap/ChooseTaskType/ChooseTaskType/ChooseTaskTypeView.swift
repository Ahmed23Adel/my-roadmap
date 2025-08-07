//
//  ChooseTaskType.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import SwiftUI



struct ChooseTaskTypeView: View {
    
    private var viewModel = ChooseTaskTypeViewModel()
    private var cols = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150))
    ]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: cols){
                ForEach(viewModel.allTaskTypes, id: \.id){ taskContainer in
                    TaskTypeContainerView(taskContainer: taskContainer)
                }
            }
            .padding() 
        }
        
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 13)
                .fill(Color.white)
        }
        .overlay{
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.yellow, lineWidth: 7)
                .padding(5)
            
        }
        .shadow(radius: 30)
    }
}

#Preview {
    ChooseTaskTypeView()
}
