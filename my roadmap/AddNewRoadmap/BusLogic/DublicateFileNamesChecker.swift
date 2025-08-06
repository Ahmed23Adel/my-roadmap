//
//  DublicateFileNamesChecker.swift
//  my roadmap
//
//  Created by ahmed on 06/08/2025.
//

import Foundation

import Foundation

struct DuplicateFileNamesChecker {
    
    func isDuplicate(fileName: String) -> Bool {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        return fileManager.fileExists(atPath: fileURL.path)
    }
}
