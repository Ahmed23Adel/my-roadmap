//
//  AdelsonConfigHolder.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import Foundation
import AdelsonAuthManager
import Combine

@MainActor
class AdelsonConfigHolder: ObservableObject {
    static let shared = AdelsonConfigHolder()
    
    @Published private(set) var config: AdelsonAuthConfig?
    @Published private(set) var loadError: Error?
    
    // Private initializer to ensure singleton usage
    private init() {}
    
    // Load config for the first time
    func loadConfig() async {
        loadError = nil
        
        self.config = await AdelsonAuthPredefinedActions.shared.wakeUp(
            appName: "MyRoadmap",
            baseUrl: "http://0.0.0.0:8000/",
            signUpEndpoint: "signup",
            otpEndpoint: "verify-otp",
            loginEndpoint: "login",
            refreshTokenEndPoint: "refresh"
        )
        
        
    }
    
    // Ensure config is loaded (call this from App startup)
    func ensureConfigLoaded() async {
        if config == nil{
            await loadConfig()
        }
    }
    
    // Recompute/refresh the config
    func recomputeConfig() async {
        await loadConfig() // Reuse the same logic
    }
    
    // Alternative: Recompute with new parameters
    func recomputeConfig(
        appName: String = "MyRoadmap",
        baseUrl: String = "http://0.0.0.0:8000/",
        signUpEndpoint: String = "signup",
        otpEndpoint: String = "verify-otp",
        loginEndpoint: String = "login",
        refreshTokenEndPoint: String = "refresh"
    ) async {
        self.config = await AdelsonAuthPredefinedActions.shared.wakeUp(
            appName: appName,
            baseUrl: baseUrl,
            signUpEndpoint: signUpEndpoint,
            otpEndpoint: otpEndpoint,
            loginEndpoint: loginEndpoint,
            refreshTokenEndPoint: refreshTokenEndPoint
        )
    }
    
    // Convenience method to get current config
    func getCurrentConfig() -> AdelsonAuthConfig? {
        return config
    }
    
    // Method to check if config is loaded
    var isConfigLoaded: Bool {
        return config != nil
    }
}
