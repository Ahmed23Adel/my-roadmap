//
//  CompletedTaskYoutubeView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct CompletedTaskYoutubeView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskYoutubePlaylist: TaskYoutubePlaylist
    @StateObject private var viewModel: CompletedTaskYoutubeViewModel
    
    init(roadmap: Roadmap, taskYoutubePlaylist: TaskYoutubePlaylist) {
        self.roadmap = roadmap
        self.taskYoutubePlaylist = taskYoutubePlaylist
        self._viewModel = StateObject(wrappedValue: CompletedTaskYoutubeViewModel(roadmap: roadmap, taskYoutubePlaylist: taskYoutubePlaylist))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                // Status Header
                HStack {
                    Text("Task Status")
                        .font(.headline)
                    Spacer()
                    Text("Completed")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.green)
                        .cornerRadius(12)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Completion Celebration
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                    
                    Text("Task Completed!")
                        .font(.title2.bold())
                        .foregroundColor(.green)
                    
                    Text("Great job on finishing this playlist!")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Playlist Info
                VStack {
                    HStack {
                        Text("Playlist Name: ")
                            .font(.title2)
                        Spacer()
                        Text(taskYoutubePlaylist.playlistName)
                            .font(.title2)
                    }
                    
                    HStack {
                        Text("Total Videos: ")
                            .font(.title2)
                        Spacer()
                        Text("\(taskYoutubePlaylist.videoCount)")
                            .font(.title2)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Open Playlist Button Section
                VStack(alignment: .leading, spacing: 8) {
                    Button {
                        if let url = URL(string: taskYoutubePlaylist.linkToYoutube) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Label("Open Playlist", systemImage: "arrow.up.right.square")
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // Completion Summary
                VStack(alignment: .leading, spacing: 8) {
                    Label("Task Summary", systemImage: "list.clipboard")
                        .font(.title3)
                    
                    if let startDate = taskYoutubePlaylist.startDate,
                       let completedAt = taskYoutubePlaylist.completedAt {
                        
                        HStack {
                            Label("Started", systemImage: "play.circle")
                            Spacer()
                            Text(startDate, style: .date)
                        }
                        
                        HStack {
                            Label("Completed", systemImage: "checkmark.circle")
                            Spacer()
                            Text(completedAt, style: .date)
                        }
                        
                        HStack {
                            Label("Duration", systemImage: "clock")
                            Spacer()
                            Text(durationText)
                        }
                        
                        HStack {
                            Label("On Time", systemImage: completedOnTime ? "checkmark.circle" : "xmark.circle")
                            Spacer()
                            Text(completedOnTime ? "Yes" : "No")
                                .foregroundColor(completedOnTime ? .green : .red)
                        }
                        
                        HStack {
                            Label("Videos Watched", systemImage: "play.rectangle.fill")
                            Spacer()
                            Text("\(taskYoutubePlaylist.numVideosWatched) / \(taskYoutubePlaylist.videoCount)")
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                                
            }
            .padding()
        }
        .navigationTitle("Completed")
    }
    
    private var durationText: String {
        guard let startDate = taskYoutubePlaylist.startDate,
              let completedAt = taskYoutubePlaylist.completedAt else {
            return "Unknown"
        }
        
        let duration = Calendar.current.dateComponents([.day], from: startDate, to: completedAt)
        let days = duration.day ?? 0
        
        if days == 0 {
            return "Same day"
        } else if days == 1 {
            return "1 day"
        } else {
            return "\(days) days"
        }
    }
    
    private var completedOnTime: Bool {
        guard let completedAt = taskYoutubePlaylist.completedAt,
              let deadline = taskYoutubePlaylist.expectedDeadline else {
            return false
        }
        return completedAt <= deadline
    }
}

#Preview {
    PreviewContentCompletedTaskYoutubeView()
}

struct PreviewContentCompletedTaskYoutubeView: View {
    var body: some View {
        do {
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskYoutubePlaylist = try TaskYoutubePlaylist.createCompletedYoutubePlaylist(
                playlistName: "SwiftUI Mastery Course",
                videoCount: 50,
                linkToYoutube: "https://youtube.com/playlist?list=example",
                title: "Master SwiftUI",
                expectedStartDate: pastDate,
                startDate: pastDate,
                completedAt: Date(),
                expectedDeadline: futureDate)
            
            let roadmap = Roadmap()
            roadmap.append(taskYoutubePlaylist)
            return AnyView(CompletedTaskYoutubeView(roadmap: roadmap, taskYoutubePlaylist: taskYoutubePlaylist))
        } catch {
            return AnyView(Text("Preview Error: \(error)")
                .foregroundColor(.red))
        }
    }
}
