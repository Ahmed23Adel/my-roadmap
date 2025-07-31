//
//  localJsonFileSaver.swift
//  myRoadmap
//
//  Created by ahmed on 14/05/2025.
//

import Foundation

class LocalJsonFileSaver{
    private var fileName: String
    
    init(fileName: String) throws {
        if fileName.isEmpty{
            throw LocalJsonFileSaveError.emptyFileName
        }
        self.fileName = fileName
    }
    
    func save (jsonString: String) throws {
        let fileURL = try getFileURL()
        if try validateJsonString(jsonString: jsonString){
            try writeJsonString(jsonString: jsonString, fileURL: fileURL)
        }
        
    }
    
    
    private func getFileURL() throws -> URL{
        let docuementDirectoreURL = try getDocuemntDirectory()
        return docuementDirectoreURL.appendingPathComponent(fileName)
    }
    
    private func getDocuemntDirectory() throws -> URL{
        guard let docuemtnDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw LocalJsonFileSaveError.docuementDirectoryNotFound
        }
        return docuemtnDirectoryURL
    }
    
    private func validateJsonString(jsonString: String) throws -> Bool{
        let data = try convertStringToData(jsonString: jsonString)
        do{
            _ = try JSONSerialization.jsonObject(with: data)
            return true
        } catch {
            throw LocalJsonFileSaveError.unableToConvertDataToJson
        }
    }
    
    private func convertStringToData(jsonString: String) throws -> Data{
        guard let data = jsonString.data(using: .utf8) else{
            throw LocalJsonFileSaveError.unableToConvertStringToData
        }
        return data
    }
    
    private func writeJsonString(jsonString: String, fileURL: URL) throws{
        do{
            try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            throw LocalJsonFileSaveError.unableToSaveFile
        }
    }
}
