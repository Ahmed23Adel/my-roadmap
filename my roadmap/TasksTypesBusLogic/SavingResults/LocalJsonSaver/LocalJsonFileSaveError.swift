//
//  LocalJsonFileSave.swift
//  myRoadmap
//
//  Created by ahmed on 14/05/2025.
//

import Foundation
enum LocalJsonFileSaveError: Error {
    case notValidJsonFormat
    case docuementDirectoryNotFound
    case unableToConvertStringToData
    case unableToConvertDataToJson
    case unableToSaveFile
    case emptyFileName
}
