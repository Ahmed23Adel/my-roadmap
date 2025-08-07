//
//  AuthUtilities.swift
//  my roadmap
//
//  Created by ahmed on 30/07/2025.
//

import Foundation
import AdelsonValidator
import AdelsonAuthManager

/// A utility class for validating user authentication input fields such as email, password, first name, and last name.
class AuthUtilities {
    
    /// Validates both email and password input fields.
    ///
    /// - Parameters:
    ///   - email: The email input field data.
    ///   - password: The password input field data.
    /// - Returns: `true` if both email and password are valid, otherwise `false`.
    func validateEmailAndPassword(_ email: InputFieldValueAndErrorData, _ password: InputFieldValueAndErrorData) -> Bool {
        let resultEmail = validateEmail(email)
        let resultPassword = validatePassword(password)
        return resultEmail && resultPassword
    }
    
    /// Validates an email input field using an email format validator.
    ///
    /// - Parameter email: The email input field data.
    /// - Returns: `true` if the email is valid, otherwise `false`.
    func validateEmail(_ email: InputFieldValueAndErrorData) -> Bool {
        email.validate(validators: [
            EmailValidator()
        ])
    }
    
    /// Validates a password input field using a predefined medium password policy.
    ///
    /// - Parameter password: The password input field data.
    /// - Returns: `true` if the password meets the policy requirements, otherwise `false`.
    func validatePassword(_ password: InputFieldValueAndErrorData) -> Bool {
        var policy = PredefinedSingleInputPolicies.mediumPasswordPolicy()
        return password.validate(policy: &policy)
    }
    
    /// Validates both first and last name input fields.
    ///
    /// - Parameters:
    ///   - firstName: The first name input field data.
    ///   - lastName: The last name input field data.
    /// - Returns: `true` if both first and last names are valid, otherwise `false`.
    func validateFirstAndLastName(_ firstName: InputFieldValueAndErrorData, _ lastName: InputFieldValueAndErrorData) -> Bool {
        let resultFirstName = validateFirstName(firstName)
        let resultLastName = validateLastName(lastName)
        return resultFirstName && resultLastName
    }
    
    /// Validates a first name input field using minimum length and letter-only validators.
    ///
    /// - Parameter firstName: The first name input field data.
    /// - Returns: `true` if the first name is valid, otherwise `false`.
    private func validateFirstName(_ firstName: InputFieldValueAndErrorData) -> Bool {
        firstName.validate(validators: [
            StringHasMinLen(minLen: 4),
            StringIsAllLetters()
        ])
    }
    
    /// Validates a last name input field using minimum length and letter-only validators.
    ///
    /// - Parameter lastName: The last name input field data.
    /// - Returns: `true` if the last name is valid, otherwise `false`.
    private func validateLastName(_ lastName: InputFieldValueAndErrorData) -> Bool {
        let result = lastName.validate(validators: [
            StringHasMinLen(minLen: 4),
            StringIsAllLetters()
        ])
        return result
    }
}
