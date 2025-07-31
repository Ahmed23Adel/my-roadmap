//
//  localSyncTrackable.swift
//  myRoadmap
//
//  Created by ahmed on 14/05/2025.
//

import Foundation

protocol StateLocalSyncTrackable{
    var localIsChanged: Bool { get set }
    var localIsSynedWithFilesDirectory: Bool { get set }
    
    func localMarkAsChanged()
    func localMarkAsNotChanged()
    func localMarkAsSynedWithFilesDirectory()
    func localMarkAsNotSynedFilesDirectory()
    
}

