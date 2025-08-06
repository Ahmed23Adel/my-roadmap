//
//  AddRoadmapStep1NameViewModel.swift
//  my roadmap
//
//  Created by ahmed on 06/08/2025.
//

import Foundation
import Combine

class AddRoadmapStep1NameViewModel: ObservableObject{
    @Published var name: String = ""
    private var coordinator: AddNewRoadmapCoordinator?
    @Published var showError = false
    @Published var errorMsg = ""
    
    func setCoordinator(coordinator: AddNewRoadmapCoordinator){
        self.coordinator = coordinator
    }
    
    func isFormValid()->Bool{
        !name.isEmpty
    }
    
    func tryToMoveToNextStep(){
        if checkDuplicateNames(){
            showErrorAlert()
        } else{
            moveToNextStep()
        }
    }
    
    private func moveToNextStep(){
        coordinator?.push(.roadmapStep)

    }
    func checkDuplicateNames() -> Bool{
        let duplicateChecker = DuplicateFileNamesChecker()
        return duplicateChecker.isDuplicate(fileName: FileNameCreator().create(fileName: name))
    }
    
    private func showErrorAlert(){
        showError = true
        errorMsg = "Another roadmap with the same name exist. please modify it"
    }
}
