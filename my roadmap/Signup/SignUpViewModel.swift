//
//  SignUpViewModel.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject{
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    
    func isFormValid() -> Bool{
        return !firstName.isEmpty &&
        !lastName.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty
    }
    
}
