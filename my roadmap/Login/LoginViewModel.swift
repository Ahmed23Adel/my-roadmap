//
//  LoginViewModel.swift
//  my roadmap
//
//  Created by ahmed on 30/07/2025.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject, ProgressViewTrigger{
    var isShowLoading: Bool = false
    var coordinator: Coordinator?
    
    @Published var email = InputFieldValueAndErrorData()
    @Published var password = InputFieldValueAndErrorData()
    
    func isFormValid() -> Bool{
        return !email.value.isEmpty &&
        !password.value.isEmpty
    }
    
    func setCoordinator(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    
    func navigateToSignUp(){
        coordinator?.navigateTo(.signup)
    }
}
