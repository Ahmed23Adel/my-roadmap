//
//  NotificationManager.swift
//  my roadmap
//
//  Created by ahmed on 11/10/2025.
//

import Foundation
import UserNotifications

class NotificationManager{
    static let shard = NotificationManager()
    
    
    func scheduleNotificationsForRoadmap(roadmap: Roadmap){
        for singleTask in roadmap.roadmap{
            guard let expectedDeadline = singleTask.expectedDeadline as Date? else { continue }
            scheduleDeadlineNotification(for: singleTask.id.uuidString, taskName: singleTask.title, deadline: expectedDeadline, isComplete: singleTask.completed)
        }
    }
    
    func scheduleDeadlineNotification(for taskId: String, taskName: String, deadline: Date, isComplete: Bool){
        // 1- Cancel notification for this task first
        cancelNotification(for: taskId)
        // 2- make sure it's not complete
        guard !isComplete else{ return }
        // 2- compute the date
        guard let notificationDate = Calendar.current.date(byAdding: .day, value: -1, to: deadline) else { return }
        guard notificationDate > Date() else { return }
        
        //3- create the notification content
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Deadline Reminder ⏰"
        notificationContent.body = "You have a deadline for the task: \(taskName)"
        notificationContent.sound = .default
        notificationContent.badge = 1
        notificationContent.userInfo = ["taskId": taskId]
        
        
        // 4- Create the trigger, when it will send the notification
        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: notificationDate
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        // 5- Create the notification
        let identifier = "task-\(taskId)"
        let request = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: trigger)
          
        // 6- Schedule it with iOS
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification: \(error)")
            } else {
                print("✅ Notification scheduled for \(notificationDate)")
            }
        }
        
    }
    
    func cancelNotification(for taskId: String){
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: ["task-\(taskId)"])
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("🗑️ Cancelled all notifications")
    }
}
