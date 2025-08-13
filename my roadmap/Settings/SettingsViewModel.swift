//
//  SettingsViewModel.swift
//  my roadmap
//
//  Created by ahmed on 13/08/2025.
//

import Foundation
import Combine
import SwiftUI

class SettingsViewModel: ObservableObject{
    @Published var allRoadmapsNames: [String] = []
    @Published var showError: Bool = false
    @Published var erroMsg = ""
    
    @AppStorage(GlobalConstants.selectedRoadmapKey) var defaultRoadmapName: String = ""
    
    
    var sortedRoadmapNames: [String] {
        guard !defaultRoadmapName.isEmpty else {
            return allRoadmapsNames.sorted()
        }
        
        var sorted = allRoadmapsNames.filter { $0 != defaultRoadmapName }.sorted()
        sorted.insert(defaultRoadmapName, at: 0)
        return sorted
    }
    
    
    init(){
        findAllRoadmapsNames()
        
        
    }
    func findAllRoadmapsNames(){
        do{
            let docDirectory = try getDocumentDirectory()
            let fileURLs = try FileManager.default.contentsOfDirectory(at: docDirectory, includingPropertiesForKeys: nil)
            
            allRoadmapsNames = fileURLs
                            .filter { $0.pathExtension.lowercased() == "json" }
                            .map { $0.deletingPathExtension().lastPathComponent }
            
        } catch{
            print("Error with reading files")
        }
    }
    
    private func getDocumentDirectory() throws -> URL{
        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) .first else{
            throw NSError(domain: "SettingsViewModel",
                                     code: 1,
                                     userInfo: [NSLocalizedDescriptionKey: "Document directory not found"])
        }
        return docURL
    }
    
    private func showErrorAlertFileNames(){
        showError = true
        erroMsg = "Error with reading roadmaps, please try again later"
    }
}

