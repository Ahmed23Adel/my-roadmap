//
//  CurrentTaskDataManager.swift
//  my roadmap
//
//  Created by ahmed on 30/09/2025.
//

import Foundation

class CurrentTaskDataManager{
    static let shared = CurrentTaskDataManager()
    
    
    private let userDefaults = UserDefaults(suiteName: "group.com.adelson.myroadmap")
    
    private let taskNameKey = "currentTaskNameKey"
    private let taskCompletionPercentageKey = "completionPercentage"
    
    func saveTask(name: String, completion: Int){
        userDefaults?.set(name, forKey: taskNameKey)
        userDefaults?.set(completion, forKey: taskCompletionPercentageKey)
        userDefaults?.synchronize()
        
    }
    
    func loadTask() -> (name: String, completion: Int)?{
        guard let name = userDefaults?.string(forKey: taskNameKey),
              let completion = userDefaults?.object(forKey: taskCompletionPercentageKey) as? Int else {
            return nil
        }
        return (name, completion)
    }
}
