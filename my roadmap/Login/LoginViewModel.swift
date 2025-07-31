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
    
    @Published var isShowAlert = false
    @Published var alertMsg = ""
    
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
    
    
    func tryToLogin(){
        isShowLoading = true
        if validateInputs() {
            Task{
                await loginUser()
                
            }
        }
        isShowLoading = false
    }
    
    private func validateInputs() -> Bool{
        AuthUtilities().validateEmailAndPassword(email, password)
    }
    private func loginUser() async{
        let requester = LoginRequests()
        let result = await requester.login(
            email: email.value,
            password: password.value,
            config: AdelsonConfigHolder.shared.config!)
        
        handleLoginResult(result)
    }
    
    private func handleLoginResult(_ result: Bool){
        if result {
            coordinator?.login()
            coordinator?.navigateTo(.home)
        } else{
            isShowAlert = true
            alertMsg = "Wrong credentials, pleaes try again"
        }
    }
}
