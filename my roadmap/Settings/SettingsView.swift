//
//  SettingsView.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView{
            Group{
                VStack{
                    Text("Default Roadmap")
                        .font(.headline)
                    Text("This is the only roadmap that you will get notified about and will appear in home screen")
                        .font(.system(size: 10))
                        .foregroundColor(Color.gray)
                    
                    if !viewModel.allRoadmapsNames.isEmpty{
                        Picker("Select roadmap", selection: $viewModel.defaultRoadmapName){
                            ForEach(viewModel.sortedRoadmapNames, id: \.self) { roadmapName in
                                Text(roadmapName)
                                    .tag(roadmapName)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity)
                            
                    }
                   Spacer()
                }
                
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.showError){
            Alert(title: Text("Error"),
                  message: Text(viewModel.erroMsg),
                  dismissButton: .default(Text("Ok")))
        }
    }
}
    
#Preview {
    SettingsView()
}
