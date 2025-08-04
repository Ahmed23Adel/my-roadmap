//
//  DrawableListOfTasks.swift
//  my roadmap
//
//  Created by ahmed on 03/08/2025.
//

import SwiftUI

struct DrawableListOfTasks: View {
    let listOfTasks: ListOfTasks
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // List title header
            
            // Display all tasks in the list vertically
            ForEach(listOfTasks.tasks, id: \.id) { task in
                DrawableSingleTask(singleTask: task)
            }
        }
        .padding()
        .position(x: listOfTasks.posX + listOfTasks.calcWidth()/2,
                 y: listOfTasks.posY + listOfTasks.calcHeight()/2)
    }
}

#Preview {
    PreviewContentDrawableList()
}

struct PreviewContentDrawableList: View {
    var body: some View {
        do {
            var currentDate: Date {
                return Date()
            }
            
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            // Create a sample list with tasks
            let listOfTasks = ListOfTasks(title: "Learning iOS Development")
            
            let task1 = try TaskArticle.createNotStartedArticle(
                articleName: "SwiftUI Basics",
                linkToArticle: "https://developer.apple.com",
                title: "Learn SwiftUI fundamentals",
                expectedStartDate: futureDate,
                expectedDeadline: futureDate
            )
            
            let task2 = try TaskBook.createNotStartedBook(
                bookName: "iOS Programming",
                numPagesInBook: 400,
                title: "Read iOS programming book",
                expectedStartDate: futureDate,
                expectedDeadline: futureDate
            )
            
            let task3 = try TaskYoutubePlaylist.createNotStartedYoutubePlaylist(
                playlistName: "iOS Tutorial Series",
                videoCount: 15,
                linkToYoutube: "https://youtube.com",
                title: "Watch tutorial series",
                expectedStartDate: futureDate,
                expectedDeadline: futureDate
            )
            
            listOfTasks.addTask(task1)
            listOfTasks.addTask(task2)
            listOfTasks.addTask(task3)
            
            // Set some positions for preview
            listOfTasks.posX = 50
            listOfTasks.posY = 50
            
            return AnyView(
                ZStack {
                    Color(.systemGray6)
                        .ignoresSafeArea()
                    
                    DrawableListOfTasks(listOfTasks: listOfTasks)
                }
            )
        } catch {
            return AnyView(
                Text("Preview Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            )
        }
    }
}
