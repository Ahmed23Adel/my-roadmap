//
//  DefaultRoadmap.swift
//  my roadmap
//
//  Created by ahmed on 13/08/2025.
//

import Foundation
import Combine
import SwiftUI

/// `DefaultRoadmapReader` is responsible for loading, parsing, and constructing the user's default roadmap.
///
/// This class:
/// - Reads the default roadmap name from persistent storage (`@AppStorage`)
/// - Loads roadmap JSON content from the app's document directory
/// - Parses JSON into strongly-typed `Task` objects
/// - Constructs a `Roadmap` object containing all parsed tasks
///
/// It supports multiple task types:
/// - Books (`TaskBook`)
/// - Articles (`TaskArticle`)
/// - Goals (`TaskGoal`)
/// - Branches (`TaskBranch`)
/// - YouTube Playlists (`TaskYoutubePlaylist`)
///
/// Usage:
/// ```swift
/// let reader = DefaultRoadmapReader()
/// let roadmap = reader.read()
/// // roadmap now contains all tasks from the default roadmap file
/// ```
class DefaultRoadmapReader: ObservableObject {
    // MARK: - Properties
        
    /// The name of the currently selected default roadmap, stored in `@AppStorage`.
    @AppStorage(GlobalConstants.selectedRoadmapKey) var defaultRoadmapName: String = ""
    
    /// Raw JSON content of the loaded roadmap.
    @Published var roadmapContent: String = ""
    
    /// The fully parsed `Roadmap` object, if successfully loaded and parsed.
    @Published var roadmap: Roadmap?
    
    // MARK: - Public Methods
       
   /// Loads the roadmap content for the currently selected default roadmap from the file system.
   ///
   /// This method:
   /// - Builds the file path for `<defaultRoadmapName>.json` in the app's document directory.
   /// - Checks if the file exists.
   /// - Reads the file's content into `roadmapContent`.
   ///
   /// If the `defaultRoadmapName` is empty or the file does not exist, this method returns without changes.
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
    
    /// Reads and returns the default roadmap as a `Roadmap` object.
        ///
    /// Internally calls:
    /// - `loadDefaultRoadmapContent()` to load JSON from file
    /// - `parseRoadmapFromJSON()` to convert the JSON into task objects
    ///
    /// - Returns: A `Roadmap` instance containing all tasks, or an empty `Roadmap` if loading fails.
    func read() -> Roadmap {
        loadDefaultRoadmapContent()
        parseRoadmapFromJSON()
        return roadmap ?? Roadmap()
    }
    
    // MARK: - Private Methods
       
       /// Parses the current `roadmapContent` string into a `Roadmap` object.
       ///
       /// Steps:
       /// 1. Convert JSON string to `Data`
       /// 2. Deserialize into an array of dictionaries (`[[String: Any]]`)
       /// 3. For each dictionary, determine the task type
       /// 4. Call the corresponding `create<TaskType>` method to build a task object
       /// 5. Append all created tasks into a new `Roadmap` instance
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
                case GlobalConstants.bookKey:
                    if let bookTask = createBookTask(from: taskDict) {
                        tasks.append(bookTask)
                    }
                    
                case GlobalConstants.articleKey:
                    if let articleTask = createArticleTask(from: taskDict) {
                        tasks.append(articleTask)
                    }
                    
                case GlobalConstants.goalKey:
                    if let goalTask = createGoalTask(from: taskDict) {
                        tasks.append(goalTask)
                    }
                    
                case GlobalConstants.branchKey:
                    if let branchTask = createBranchTask(from: taskDict) {
                        tasks.append(branchTask)
                    }
                    
                case GlobalConstants.youtubeKey:
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
        guard let title = dict[BookConstants.titleKey] as? String,
              let bookName = dict[BookConstants.bookNameKey] as? String,
              let numPagesInBook = dict[BookConstants.numPagesInBookKey] as? Int,
              let taskStatus = dict[BookConstants.taskStatusKey] as? String else {
            return nil
        }
        
        let numPagesRead = dict[BookConstants.numPagesReadKey] as? Int ?? 0
        let progress = dict[BookConstants.progressKey] as? Int ?? 0
        let expectedStartDate = parseDate(dict[BookConstants.expectedStartDateKey] as? String)
        let expectedDeadline = parseDate(dict[BookConstants.expectedDeadlineKey] as? String)
        let startDate = parseDate(dict[BookConstants.startDateKey] as? String)
        let completedAt = parseDate(dict[BookConstants.completedAtKey] as? String)
        
        do {
            switch taskStatus {
            case GlobalConstants.statusNotStarted:
                return try TaskBook.createNotStartedBook(
                    bookName: bookName,
                    numPagesInBook: numPagesInBook,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    expectedDeadline: expectedDeadline,
                    isOnCreation: false
                )
                
            case GlobalConstants.statusInProgress:
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
                    taskStatus: TaskStatus.inProgress,
                    isOnCreation: false
                )
                
            case GlobalConstants.statusCompleted:
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
                    expectedDeadline: expectedDeadline,
                    isOnCreation: false
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
        guard let title = dict[ArticleConstants.titleKey] as? String,
              let articleName = dict[ArticleConstants.articleNameKey] as? String,
              let linkToArticle = dict[ArticleConstants.linkToArticleKey] as? String,
              let taskStatus = dict[ArticleConstants.taskStatusKey] as? String else {
            return nil
        }
        
        let progress = dict[ArticleConstants.progressKey] as? Int ?? 0
        let expectedStartDate = parseDate(dict[ArticleConstants.expectedStartDateKey] as? String)
        let expectedDeadline = parseDate(dict[ArticleConstants.expectedDeadlineKey] as? String)
        let startDate = parseDate(dict[ArticleConstants.startDateKey] as? String)
        let completedAt = parseDate(dict[ArticleConstants.completedAtKey] as? String)
        
        do {
            switch taskStatus {
            case GlobalConstants.statusNotStarted:
                return try TaskArticle.createNotStartedArticle(
                    articleName: articleName,
                    linkToArticle: linkToArticle,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    expectedDeadline: expectedDeadline,
                    isOnCreation: false
                )
                
            case GlobalConstants.statusInProgress:
                guard let startDate = startDate else { return nil }
                return try TaskArticle.createInProgressArticle(
                    articleName: articleName,
                    linkToArticle: linkToArticle,
                    title: title,
                    progress: progress,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    expectedDeadline: expectedDeadline,
                    taskStatus: TaskStatus.inProgress,
                    isOnCreation: false
                )
                
            case GlobalConstants.statusCompleted:
                guard let startDate = startDate,
                      let completedAt = completedAt else { return nil }
                return try TaskArticle.createCompletedArticle(
                    articleName: articleName,
                    linkToArticle: linkToArticle,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    completedAt: completedAt,
                    expectedDeadline: expectedDeadline,
                    isOnCreation: false
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
        guard let title = dict[GoalConstants.titleKey] as? String,
              let details = dict[GoalConstants.detailsKey] as? String,
              let taskStatus = dict[GoalConstants.taskStatusKey] as? String else {
            return nil
        }
        
        let imageLink = dict[GoalConstants.imageLinkKey] as? String
        let progress = dict[GoalConstants.progressKey] as? Int ?? 0
        let expectedStartDate = parseDate(dict[GoalConstants.expectedStartDateKey] as? String)
        let expectedDeadline = parseDate(dict[GoalConstants.expectedDeadlineKey] as? String)
        let startDate = parseDate(dict[GoalConstants.startDateKey] as? String)
        let completedAt = parseDate(dict[GoalConstants.completedAtKey] as? String)
        
        do {
            switch taskStatus {
            case GlobalConstants.statusNotStarted:
                return try TaskGoal.createNotStartedGoal(
                    details: details,
                    imageLink: imageLink,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    expectedDeadline: expectedDeadline,
                    isOnCreation: false
                )
                
            case GlobalConstants.statusInProgress:
                guard let startDate = startDate else { return nil }
                return try TaskGoal.createInProgressGoal(
                    details: details,
                    imageLink: imageLink,
                    title: title,
                    progress: progress,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    expectedDeadline: expectedDeadline,
                    taskStatus: TaskStatus.inProgress,
                    isOnCreation: false
                )
                
            case GlobalConstants.statusCompleted:
                guard let startDate = startDate,
                      let completedAt = completedAt else { return nil }
                return try TaskGoal.createCompletedGoal(
                    details: details,
                    imageLink: imageLink,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    startDate: startDate,
                    completedAt: completedAt,
                    expectedDeadline: expectedDeadline,
                    isOnCreation: false
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
        if let branch1Array = dict[BranchConstants.branch1Key] as? [[String: Any]] {
            do {
                let listOfTasks1 = ListOfTasks(title: "Branch 1")
                
                for branchTaskDict in branch1Array {
                    guard let type = branchTaskDict[BranchConstants.typeKey] as? String else { continue }
                    
                    var task: TaskObject?
                    switch type {
                    case GlobalConstants.bookKey:
                        task = createBookTask(from: branchTaskDict)
                    case GlobalConstants.articleKey:
                        task = createArticleTask(from: branchTaskDict)
                    case GlobalConstants.goalKey:
                        task = createGoalTask(from: branchTaskDict)
                    case GlobalConstants.youtubeKey:
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
        if let branch2Array = dict[BranchConstants.branch2Key] as? [[String: Any]] {
            do {
                let listOfTasks2 = ListOfTasks(title: "Branch 2")
                
                for branchTaskDict in branch2Array {
                    guard let type = branchTaskDict[BranchConstants.typeKey] as? String else { continue }
                    
                    var task: TaskObject?
                    switch type {
                    case GlobalConstants.bookKey:
                        task = createBookTask(from: branchTaskDict)
                    case GlobalConstants.articleKey:
                        task = createArticleTask(from: branchTaskDict)
                    case GlobalConstants.goalKey:
                        task = createGoalTask(from: branchTaskDict)
                    case GlobalConstants.youtubeKey:
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
        guard let title = dict[YoutubeConstants.titleKey] as? String,
              let playlistName = dict[YoutubeConstants.playlistNameKey] as? String,
              let linkToYoutube = dict[YoutubeConstants.linkToYoutubeKey] as? String,
              let videoCount = dict[YoutubeConstants.videoCountKey] as? Int,
              let taskStatus = dict[YoutubeConstants.taskStatusKey] as? String else {
            return nil
        }
        
        let numVideosWatched = dict[YoutubeConstants.numVideosWatchedKey] as? Int ?? 0
        let progress = dict[YoutubeConstants.progressKey] as? Int ?? 0
        let expectedStartDate = parseDate(dict[YoutubeConstants.expectedStartDateKey] as? String)
        let expectedDeadline = parseDate(dict[YoutubeConstants.expectedDeadlineKey] as? String)
        let startDate = parseDate(dict[YoutubeConstants.startDateKey] as? String)
        let completedAt = parseDate(dict[YoutubeConstants.completedAtKey] as? String)
        
        do {
            switch taskStatus {
            case GlobalConstants.statusNotStarted:
                return try TaskYoutubePlaylist.createNotStartedYoutubePlaylist(
                    playlistName: playlistName,
                    videoCount: videoCount,
                    linkToYoutube: linkToYoutube,
                    title: title,
                    expectedStartDate: expectedStartDate,
                    expectedDeadline: expectedDeadline,
                    isOnCreation: false
                )
                
            case GlobalConstants.statusInProgress:
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
                    taskStatus: TaskStatus.inProgress,
                    isOnCreation: false
                )
                
            case GlobalConstants.statusCompleted:
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
                    expectedDeadline: expectedDeadline,
                    isOnCreation: false
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
    
    
}
