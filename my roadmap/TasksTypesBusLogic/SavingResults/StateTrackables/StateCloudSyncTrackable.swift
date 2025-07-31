//
//  SyncTrackable.swift
//  myRoadmap
//
//  Created by ahmed on 14/05/2025.
//

import Foundation
/*
    Better use it with Observable Object pattern
 */
protocol StateCloudSyncTrackable{
    var cloudIsChanged: Bool { get }
    var cloudIsSynedWithCloud: Bool { get }
    
    func cloudMarkAsChanged()
    func cloudMarkAsNotChanged()
    func cloudMarkAsSynedWithCloud()
    func cloudMarkAsNotSynedWithCloud()
    
}
