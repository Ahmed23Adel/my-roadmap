//
//  File.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import Foundation
import Combine
import AdelsonValidator

class InputFieldValueAndErrorData: ObservableObject{
    @Published var value = ""
    @Published var errorMsg  = ""
    @Published var showError = false
    
    func validate(validators: [any SingleInputValidator<String>]) -> Bool{
        var policy = genPolicyObject(validators: validators)
        return validate(policy: &policy)
    }
    
    func validate(policy: inout any SingleInputPolicyType<String>)-> Bool{
        let result = policy.check()
        if !result{
            extractErrorMsg(error: policy.getError() as! AdelsonReadableError)
            showError = true
        } else{
            clearError()
        }
        return result
    }
    
    private func genPolicyObject(validators: [any SingleInputValidator<String>]) -> any SingleInputPolicyType<String>{
        var policy = SingleInputPolicy(singleInputValidators: validators)
        policy.setInput(inputs: [self.value])
        return policy
    }
    
    private func extractErrorMsg(error: any AdelsonReadableError){
        errorMsg = error.message
    }
    
    private func clearError(){
        showError = false
        errorMsg = ""
    }
}
