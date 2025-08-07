//
//  InputFieldValueAndErrorData.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import Foundation
import Combine
import AdelsonValidator

/// A view model for handling the state, validation, and error messaging of a single input field.
///
/// This class stores the current value of a text input field, runs validation rules,
/// and exposes error messages and flags that are observable in the UI.
class InputFieldValueAndErrorData: ObservableObject {
    
    /// The current text value entered by the user.
    @Published var value = ""
    
    /// The error message to display if validation fails.
    @Published var errorMsg = ""
    
    /// A Boolean indicating whether the error message should be shown in the UI.
    @Published var showError = false

    /// Validates the current value using a list of validators.
    ///
    /// This method builds a policy object from the given validators and runs validation.
    ///
    /// - Parameter validators: An array of `SingleInputValidator` objects to apply.
    /// - Returns: `true` if the value passes all validations, otherwise `false`.
    func validate(validators: [any SingleInputValidator<String>]) -> Bool {
        var policy = genPolicyObject(validators: validators)
        return validate(policy: &policy)
    }

    /// Validates the current value using a custom input policy.
    ///
    /// - Parameter policy: A policy object containing validation rules.
    /// - Returns: `true` if the value passes the policy check, otherwise `false`.
    func validate(policy: inout any SingleInputPolicyType<String>) -> Bool {
        // i use inout as without it, it gives error `Cannot use mutating member on immutable value: 'policy' is a 'let' constant`
        let result = policy.check()
        if !result {
            extractErrorMsg(error: policy.getError() as! AdelsonReadableError)
            showError = true
        } else {
            clearError()
        }
        return result
    }

    /// Generates a validation policy object from a list of validators.
    ///
    /// - Parameter validators: An array of `SingleInputValidator` rules.
    /// - Returns: A policy object that can be used for validation.
    private func genPolicyObject(validators: [any SingleInputValidator<String>]) -> any SingleInputPolicyType<String> {
        var policy = SingleInputPolicy(singleInputValidators: validators)
        policy.setInput(inputs: [self.value])
        return policy
    }

    /// Extracts and sets the error message from a validation error.
    ///
    /// - Parameter error: An object conforming to `AdelsonReadableError` that provides the error message.
    private func extractErrorMsg(error: any AdelsonReadableError) {
        errorMsg = error.message
    }

    /// Clears the current error message and hides the error state.
    private func clearError() {
        showError = false
        errorMsg = ""
    }
}
