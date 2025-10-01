//
//  my_roadmapApp.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI
import AdelsonAuthManager
import AdelsonValidator

@main
struct my_roadmapApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator()
                .task {
                    await AdelsonConfigHolder.shared.ensureConfigLoaded()
                }
                .task{
                    let roadmap = DefaultRoadmapReader().read()
                    let (name, progress) = roadmap.getCurrentTask()
                    CurrentTaskDataManager.shared.saveTask(name: name, completion: progress)
                    print("widget data saved")
                    print(CurrentTaskDataManager.shared.loadTask())
                    
                }
        }
    }
}
