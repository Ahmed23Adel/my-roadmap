//
//  AuthUtilities.swift
//  my roadmap
//
//  Created by ahmed on 30/07/2025.
//

import Foundation
import AdelsonValidator
import AdelsonAuthManager

class AuthUtilities{
    
    func validateEmailAndPassword(_ email: InputFieldValueAndErrorData, _ password: InputFieldValueAndErrorData) -> Bool{
        let resultEmail = validateEmail(email)
        let resultPassword = validatePassword(password)
        return resultEmail && resultPassword
    }
    
    
    func validateEmail(_ email: InputFieldValueAndErrorData) -> Bool{
        email.validate(validators: [
            EmailValidator()
        ])
    }
    
    func validatePassword(_ password: InputFieldValueAndErrorData) -> Bool{
        var policy = PredefinedSingleInputPolicies.mediumPasswordPolicy()
        return password.validate(policy: &policy)
    }
    
    func validateFirstAndLastName(_ firstName: InputFieldValueAndErrorData, _ lastName: InputFieldValueAndErrorData) -> Bool{
        let resultFirstName = validateFirstName(firstName)
        let resultLastName = validateLastName(lastName)
        return resultFirstName && resultLastName
    }
    
    private func validateFirstName(_ firstName: InputFieldValueAndErrorData) -> Bool{
        firstName.validate(validators: [
            StringHasMinLen(minLen: 4),
            StringIsAllLetters()
        ])
    }
    
    private func validateLastName(_ lastName: InputFieldValueAndErrorData) -> Bool{
        let result = lastName.validate(validators: [
            StringHasMinLen(minLen: 4),
            StringIsAllLetters()
        ])
        return result
    }
}
