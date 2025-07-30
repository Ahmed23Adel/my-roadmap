//
//  SignUp.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import Foundation
import AdelsonAuthManager
import AdelsonValidator

nonisolated(unsafe) public struct MyRoadmapSignUpResponse: Codable, Sendable {
    public let message: String

    public init(message: String) {
        self.message = message
    }
}



class SignUpRequests{
    
    func signUp(firstName: String,
                lastName: String,
                email: String,
                password: String,
                config: AdelsonAuthConfig
    ) async -> Bool{
        let operation = TraditionslSignUpOperation<MyRoadmapSignUpResponse>(
            username: email,
            password: password,
            config: config,
            extraUserInfo: ["first_name": firstName, "last_name": lastName]
        )
        
        return await operation.execute()
    }
}
