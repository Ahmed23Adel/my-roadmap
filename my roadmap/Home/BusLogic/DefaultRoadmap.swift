//
//  DefaultRoadmap.swift
//  my roadmap
//
//  Created by ahmed on 13/08/2025.
//

import Foundation
import Combine
import SwiftUI


class DefaultRoadmapReader: ObservableObject {
    @AppStorage(GlobalConstants.selectedRoadmapKey) var defaultRoadmapName: String = ""
    @Published var roadmapContent: String = ""
    @Published var roadmap: Roadmap?
    
    func loadDefaultRoadmapContent() {
        guard !defaultRoadmapName.isEmpty else { return }
        
        do {
            let fileName = "\(defaultRoadmapName).json"
            let fileURL = try getFileURL(fileName: fileName)
            
            guard FileManager.default.fileExists(atPath: fileURL.path) else { return }
            roadmapContent = try String(contentsOf: fileURL, encoding: .utf8)
            print("roadmapContent", roadmapContent)
            
        } catch {
            print("Error loading roadmap content: \(error)")
        }
    }
    
    private func parseRoadmapFromJSON() {
        guard !roadmapContent.isEmpty else { return }
        
        do {
            // Convert JSON string to Data
            let data = roadmapContent.data(using: .utf8)!
            // Parse JSON into array of dictionaries
            let jsonArray = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
            
            var tasks: [Any] = []
            
            // Loop through each dictionary
            for taskDict in jsonArray {
                guard let type = taskDict["type"] as? String else { continue }
                
                // Create appropriate task object based on type
                switch type {
                case "book":
                    if let bookTask = createBookTask(from: taskDict) {
                        tasks.append(bookTask)
                    }
                    
                case "article":
                    if let articleTask = createArticleTask(from: taskDict) {
                        tasks.append(articleTask)
                    }
                    
                case "goal":
                    if let goalTask = createGoalTask(from: taskDict) {
                        tasks.append(goalTask)
                    }
                    
                case "branch":
                    if let branchTask = createBranchTask(from: taskDict) {
                        tasks.append(branchTask)
                    }
                    
                case "youtube":
                    if let playlistTask = createYoutubePlaylistTask(from: taskDict) {
                        tasks.append(playlistTask)
                    }
                    
                default:
                    print("Unknown task type: \(type)")
                }
            }
            
            // Create roadmap with parsed tasks
            roadmap = Roadmap()
            for singleTasks in tasks{
                roadmap?.append(singleTasks as! any GenericState)
            }
            
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
    
    // MARK: - Task Creation Methods
    
    private func createBookTask(from dict: [String: Any]) -> TaskBook? {
        guard let title = dict["title"] as? String,
              let bookName = dict["bookName"] as? String,
              let numPagesInBook = dict["numPagesInBook"] as? Int,
              let taskStatus = dict["taskStatus"] as? String else {
            return nil
        }
        
        let numPagesRead = dict["numPagesRead"] as? Int ?? 0
        let progress = dict["progress"] as? Int ?? 0
        let expectedStartDate = parseDate(dict["expectedStartDate"] as? String)
        let expectedDeadline = parseDate(dict["expectedDeadline"] as? String)
        let startDate = parseDate(dict["startDate"] as? String)
        let completedAt = parseDate(dict["completedAt"] as? String)
        
        do {
            switch taskStatus {
            case "notStarted":
                return try TaskBook.createNotStartedBook(
                    bookName: bookName,
                    numPagesInBook: numPagesInBook,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    expectedDeadline: expectedDeadline
                )
                
            case "inProgress":
                guard let startDate = startDate else { return nil }
                return try TaskBook.createInProgressBook(
                    bookName: bookName,
                    numPagesInBook: numPagesInBook,
                    numPagesRead: numPagesRead,
                    title: title,
                    progress: progress,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    expectedDeadline: expectedDeadline,
                    taskStatus: TaskStatus.inProgress
                )
                
            case "completed":
                guard let startDate = startDate,
                      let completedAt = completedAt else { return nil }
                return try TaskBook.createCompletedBook(
                    bookName: bookName,
                    numPagesInBook: numPagesInBook,
                    numPagesRead: numPagesRead,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    completedAt: completedAt,
                    expectedDeadline: expectedDeadline
                )
                
            default:
                return nil
            }
        } catch {
            print("Error creating TaskBook: \(error)")
            return nil
        }
    }
    
    private func createArticleTask(from dict: [String: Any]) -> TaskArticle? {
        guard let title = dict["title"] as? String,
              let articleName = dict["articleName"] as? String,
              let linkToArticle = dict["linkToArticle"] as? String,
              let taskStatus = dict["taskStatus"] as? String else {
            return nil
        }
        
        let progress = dict["progress"] as? Int ?? 0
        let expectedStartDate = parseDate(dict["expectedStartDate"] as? String)
        let expectedDeadline = parseDate(dict["expectedDeadline"] as? String)
        let startDate = parseDate(dict["startDate"] as? String)
        let completedAt = parseDate(dict["completedAt"] as? String)
        
        do {
            switch taskStatus {
            case "notStarted":
                return try TaskArticle.createNotStartedArticle(
                    articleName: articleName,
                    linkToArticle: linkToArticle,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    expectedDeadline: expectedDeadline
                )
                
            case "inProgress":
                guard let startDate = startDate else { return nil }
                return try TaskArticle.createInProgressArticle(
                    articleName: articleName,
                    linkToArticle: linkToArticle,
                    title: title,
                    progress: progress,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    expectedDeadline: expectedDeadline,
                    taskStatus: TaskStatus.inProgress
                )
                
            case "completed":
                guard let startDate = startDate,
                      let completedAt = completedAt else { return nil }
                return try TaskArticle.createCompletedArticle(
                    articleName: articleName,
                    linkToArticle: linkToArticle,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    completedAt: completedAt,
                    expectedDeadline: expectedDeadline
                )
                
            default:
                return nil
            }
        } catch {
            print("Error creating TaskArticle: \(error)")
            return nil
        }
    }
    
    private func createGoalTask(from dict: [String: Any]) -> TaskGoal? {
        guard let title = dict["title"] as? String,
              let details = dict["details"] as? String,
              let taskStatus = dict["taskStatus"] as? String else {
            return nil
        }
        
        let imageLink = dict["imageLink"] as? String
        let progress = dict["progress"] as? Int ?? 0
        let expectedStartDate = parseDate(dict["expectedStartDate"] as? String)
        let expectedDeadline = parseDate(dict["expectedDeadline"] as? String)
        let startDate = parseDate(dict["startDate"] as? String)
        let completedAt = parseDate(dict["completedAt"] as? String)
        
        do {
            switch taskStatus {
            case "notStarted":
                // You'll need to implement TaskGoal.createNotStartedGoal() method
                // For now, using inProgress as fallback
                return try TaskGoal.createNotStartedGoal(
                    details: details,
                    imageLink: imageLink,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    expectedDeadline: expectedDeadline)
                
            case "inProgress":
                guard let startDate = startDate else { return nil }
                return try TaskGoal.createInProgressGoal(
                    details: details,
                    imageLink: imageLink,
                    title: title,
                    progress: progress,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    expectedDeadline: expectedDeadline,
                    taskStatus: TaskStatus.inProgress
                )
                
            case "completed":
                guard let startDate = startDate,
                      let completedAt = completedAt else { return nil }
                return try TaskGoal.createCompletedGoal(
                    details: details,
                    imageLink: imageLink,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    completedAt: completedAt,
                    expectedDeadline: expectedDeadline
                )
                
            default:
                return nil
            }
        } catch {
            print("Error creating TaskGoal: \(error)")
            return nil
        }
    }
    
    private func createBranchTask(from dict: [String: Any]) -> TaskBranch? {
        let branch = TaskBranch(title: "Branch")
        
        // Parse branch1
        if let branch1Array = dict["branch1"] as? [[String: Any]] {
            do {
                let listOfTasks1 = ListOfTasks(title: "Branch 1")
                
                for branchTaskDict in branch1Array {
                    guard let type = branchTaskDict["type"] as? String else { continue }
                    
                    var task: TaskObject?
                    switch type {
                    case "book":
                        task = createBookTask(from: branchTaskDict)
                    case "article":
                        task = createArticleTask(from: branchTaskDict)
                    case "goal":
                        task = createGoalTask(from: branchTaskDict)
                    case "youtubePlaylist":
                        task = createYoutubePlaylistTask(from: branchTaskDict)
                    default:
                        continue
                    }
                    
                    if let task = task {
                        listOfTasks1.append(task)
                    }
                }
                
                try branch.addBranch(branch: listOfTasks1)
            } catch {
                print("Error creating branch1: \(error)")
                return nil
            }
        }
        
        // Parse branch2
        if let branch2Array = dict["branch2"] as? [[String: Any]] {
            do {
                let listOfTasks2 = ListOfTasks(title: "Branch 2")
                
                for branchTaskDict in branch2Array {
                    guard let type = branchTaskDict["type"] as? String else { continue }
                    
                    var task: TaskObject?
                    switch type {
                    case "book":
                        task = createBookTask(from: branchTaskDict)
                    case "article":
                        task = createArticleTask(from: branchTaskDict)
                    case "goal":
                        task = createGoalTask(from: branchTaskDict)
                    case "youtube":
                        task = createYoutubePlaylistTask(from: branchTaskDict)
                    default:
                        continue
                    }
                    
                    if let task = task {
                        listOfTasks2.append(task)
                    }
                }
                
                try branch.addBranch(branch: listOfTasks2)
            } catch {
                print("Error creating branch2: \(error)")
                return nil
            }
        }
        
        return branch
    }
    
    private func createYoutubePlaylistTask(from dict: [String: Any]) -> TaskYoutubePlaylist? {
        guard let title = dict["title"] as? String,
              let playlistName = dict["playlistName"] as? String,
              let linkToYoutube = dict["linkToYoutube"] as? String,
              let videoCount = dict["videoCount"] as? Int,
              let taskStatus = dict["taskStatus"] as? String else {
            return nil
        }
        
        let numVideosWatched = dict["numVideosWatched"] as? Int ?? 0
        let progress = dict["progress"] as? Int ?? 0
        let expectedStartDate = parseDate(dict["expectedStartDate"] as? String)
        let expectedDeadline = parseDate(dict["expectedDeadline"] as? String)
        let startDate = parseDate(dict["startDate"] as? String)
        let completedAt = parseDate(dict["completedAt"] as? String)
        
        do {
            switch taskStatus {
            case "notStarted":
                return try TaskYoutubePlaylist.createNotStartedYoutubePlaylist(
                    playlistName: playlistName,
                    videoCount: videoCount,
                    linkToYoutube: linkToYoutube,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    expectedDeadline: expectedDeadline
                )
                
            case "inProgress":
                guard let startDate = startDate else { return nil }
                return try TaskYoutubePlaylist.createInProgressYoutubePlaylist(
                    playlistName: playlistName,
                    videoCount: videoCount,
                    numVideosWatched: numVideosWatched,
                    linkToYoutube: linkToYoutube,
                    title: title,
                    progress: progress,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    expectedDeadline: expectedDeadline,
                    taskStatus: TaskStatus.inProgress
                )
                
            case "completed":
                guard let startDate = startDate,
                      let completedAt = completedAt else { return nil }
                return try TaskYoutubePlaylist.createCompletedYoutubePlaylist(
                    playlistName: playlistName,
                    videoCount: videoCount,
                    linkToYoutube: linkToYoutube,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    completedAt: completedAt,
                    expectedDeadline: expectedDeadline
                )
                
            default:
                return nil
            }
        } catch {
            print("Error creating TaskYoutubePlaylist: \(error)")
            return nil
        }
    }
    
    // MARK: - Helper Methods
    
    private func parseDate(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: dateString)
    }
    
    private func getFileURL(fileName: String) throws -> URL {
        let documentDirectory = try getDocumentDirectory()
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    private func getDocumentDirectory() throws -> URL {
        guard let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory,
                                                                 in: .userDomainMask).first else {
            throw NSError(domain: "DefaultRoadmap",
                         code: 1,
                         userInfo: [NSLocalizedDescriptionKey: "Document directory not found"])
        }
        return documentDirectoryURL
    }
    
    func read() -> Roadmap {
        loadDefaultRoadmapContent()
        
        parseRoadmapFromJSON()
        
        return roadmap ?? Roadmap()
    }
}
