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

class SignUpViewModel: ObservableObject{
    @Published var firstName = InputFieldValueAndErrorData()
    @Published var lastName = InputFieldValueAndErrorData()
    @Published var email = InputFieldValueAndErrorData()
    @Published var password = InputFieldValueAndErrorData()
     
    
    func isFormValid() -> Bool{
        return !firstName.value.isEmpty &&
        !lastName.value.isEmpty &&
        !email.value.isEmpty &&
        !password.value.isEmpty
    }
    
    func tryToSubmit(){
        if validateInputs(){
            Task{
                await signUpUser()
            }
        }
    }
    
    private func validateInputs() -> Bool{
        return validateFirstName() && validateLastName() && validateEmail() && validatePassword()
    }
    
    private func validateFirstName() -> Bool{
        firstName.validate(validators: [
            StringHasMinLen(minLen: 4),
            StringIsAllLetters()
        ])
    }
    
    private func validateLastName() -> Bool{
        lastName.validate(validators: [
            StringHasMinLen(minLen: 4),
            StringIsAllLetters()
        ])
    }
    
    private func validateEmail() -> Bool{
        email.validate(validators: [
            EmailValidator()
        ])
    }
    
    private func validatePassword() -> Bool{
        var policy = PredefinedSingleInputPolicies.mediumPasswordPolicy()
        return password.validate(policy: &policy)
    }
    
    private func signUpUser() async {
        let requester = SignUpRequests()
        let _ = await requester.signUp(firstName: firstName.value,
                         lastName: lastName.value,
                         email: email.value,
                         password: password.value,
                         config: AdelsonConfigHolder.shared.config!)
    }
}


