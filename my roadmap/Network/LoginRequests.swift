//
//  LoginRequests.swift
//  my roadmap
//
//  Created by ahmed on 30/07/2025.
//

import Foundation


import Foundation
import AdelsonAuthManager
import AdelsonValidator

class LoginRequests{
    
    func login(email: String,
                password: String,
                config: AdelsonAuthConfig
    ) async -> Bool{
        let operation = TraditionalLogIn(
            username: email,
            password: password,
            config: config,
            networkService: AlamoFireNetworkService()
        )
        
        return await operation.execute()
    }
}
