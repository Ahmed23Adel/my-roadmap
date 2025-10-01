//
//  CurrentTaskWidget.swift
//  CurrentTaskWidget
//
//  Created by ahmed on 30/09/2025.
//

import WidgetKit
import SwiftUI

struct TaskEntry: TimelineEntry{
    let date: Date
    let taskName: String
    let taskProgress: Int
}
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TaskEntry {
        TaskEntry(date: Date(), taskName: "Learn HTML", taskProgress: 40)
        
    }

    func getSnapshot(in context: Context, completion: @escaping (TaskEntry) -> ()) {
        let entry = TaskEntry(date: Date(), taskName: "Learn HTML", taskProgress: 40)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TaskEntry>) -> ()) {
        let currentDate = Date()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
        if let (name, progress) =  CurrentTaskDataManager.shared.loadTask(){
            let entry = TaskEntry(date: currentDate, taskName: name, taskProgress: progress)
            print("entry: ", entry)
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
            
        } else{
            print("no entry")
            let entry = TaskEntry(date: Date(), taskName: "No task yet", taskProgress: 0)
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
            
        }
    }

}


struct CurrentTaskWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack{
            // task name
            Text(entry.taskName)
                .font(.headline)
                .foregroundColor(Color.black)
            Spacer()
            // task progress
            CircularProgressView(progress: entry.taskProgress)
        }
        .padding()
        .containerBackground(Color(red: 242/255, green: 240/255, blue: 239/255), for: .widget)
    }
}

struct CircularProgressView: View {
    let progress: Int // 0-100
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(
                    Color.black.opacity(0.2),
                    lineWidth: 8
                )
            
            // Progress circle
            Circle()
                .trim(from: 0, to: CGFloat(progress) / 100.0)
                .stroke(
                    Color.green,
                    style: StrokeStyle(
                        lineWidth: 8,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90)) // Start from top
                .animation(.easeInOut, value: progress)
            
            // Percentage text in the middle
            Text("\(progress)%")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.black)
        }
        .frame(width: 40, height: 40)
    }
}
struct CurrentTaskWidget: Widget {
    let kind: String = "CurrentTaskWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CurrentTaskWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                CurrentTaskWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    CurrentTaskWidget()
} timeline: {
    TaskEntry(date: Date(), taskName: "Learn HTML", taskProgress: 40)
//    SimpleEntry(date: .now, emoji: "🤩")
}
