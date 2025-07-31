//
//  SignUpViewModel.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import Foundation
import Combine
import AdelsonValidator
import AdelsonAuthManager
import SwiftUI

class SignUpViewModel: ProgressViewTrigger, ObservableObject {
    @Published var firstName = InputFieldValueAndErrorData()
    @Published var lastName = InputFieldValueAndErrorData()
    @Published var email = InputFieldValueAndErrorData()
    @Published var password = InputFieldValueAndErrorData()
    @Published var isShowLoading = false
    var coordinator: Coordinator?
    
    @Published var isShowAlert = false
    @Published var alertMsg = ""
    
    func setCoordinator(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    
    func isFormValid() -> Bool{
        return !firstName.value.isEmpty &&
        !lastName.value.isEmpty &&
        !email.value.isEmpty &&
        !password.value.isEmpty
    }
    
    func tryToSubmit(){
        isShowLoading = true
        if validateInputs(){
            Task{
                await signUpUser()
            }
        }
        isShowLoading = false
    }
    
    private func validateInputs() -> Bool{
        let utils = AuthUtilities()
        let resultFirstAndLastName = utils.validateFirstAndLastName(firstName, lastName)
        let resultEmailAndPassword = utils.validateEmailAndPassword(email, password)
        return resultFirstAndLastName && resultEmailAndPassword
    }
    
   
    
    private func signUpUser() async {
        let requester = SignUpRequests()
        let result = await requester.signUp(firstName: firstName.value,
                                       lastName: lastName.value,
                                       email: email.value,
                                       password: password.value,
                                       config: AdelsonConfigHolder.shared.config!)
        handleSignupResult(result)
    }
    
    func navigateToLoginScreen(){
        coordinator?.navigateTo(.login)
    }
    
    private func handleSignupResult(_ result: Bool){
        if result {
            coordinator?.navigateTo(.login)
        } else{
            isShowAlert = true
            alertMsg = "Error with siging up, pleaes try again"
        }
    }
    
    
}

