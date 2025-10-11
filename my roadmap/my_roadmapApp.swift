//
//  my_roadmapApp.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI
import AdelsonAuthManager
import AdelsonValidator
import WidgetKit
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
                    WidgetCenter.shared.reloadAllTimelines()
                    
                }
                .task{
                    await requestNotificationPermission()
                }
        }
    }
    
    func requestNotificationPermission() async {
        do{
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound,.badge]
            )
            if granted {
                print("✅ Notification permission granted")
            } else {
                print("❌ Notification permission denied")
            }
        } catch {
            print("❌ Error requesting notification permission: \(error)")
        }
    }
}
