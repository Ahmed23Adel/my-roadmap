//
//  MainHomeTaskYoutubeEditor.swift
//  my roadmap
//
//  Created by ahmed on 15/08/2025.
//

import SwiftUI

struct MainHomeTaskYoutubeEditor: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskYoutube: TaskYoutubePlaylist
    @State private var videosToAdd: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) { // Main vertical layout
                
                // MARK: Task Status
                HStack {
                    Text("Task Status")
                        .font(.headline)
                    Spacer()
                    statusLabel
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // MARK: Playlist Info
                VStack(alignment: .leading, spacing: 8) {
                    Label(taskYoutube.playlistName, systemImage: "play.rectangle.fill")
                        .font(.title3)
                    
                    Button {
                        if let url = URL(string: taskYoutube.linkToYoutube) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Label("Open Playlist", systemImage: "arrow.up.right.square")
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // MARK: Video Progress
                VStack(alignment: .leading, spacing: 12) {
                    Label("Progress", systemImage: "chart.bar.fill")
                        .font(.headline)
                    
                    ProgressView(value: Double(taskYoutube.numVideosWatched),
                                 total: Double(taskYoutube.videoCount))
                        .tint(.blue)
                    
                    Text("\(taskYoutube.numVideosWatched) / \(taskYoutube.videoCount) videos")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Add videos stepper if in progress
                    if taskYoutube.taskStatus == .inProgress {
                        HStack {
                            Text("Add videos:")
                                .font(.subheadline)
                            
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Button {
                                    if videosToAdd > 0 { videosToAdd -= 1 }
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                                
                                TextField("0", value: $videosToAdd, formatter: NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 60)
                                    .multilineTextAlignment(.center)
                                
                                Button {
                                    let maxVideos = taskYoutube.videoCount - taskYoutube.numVideosWatched
                                    if videosToAdd < maxVideos { videosToAdd += 1 }
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            
                            Button("Update") {
                                // Example logic
                                // taskYoutube.numVideosWatched += videosToAdd
                                videosToAdd = 0
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(videosToAdd <= 0 || (taskYoutube.numVideosWatched + videosToAdd) > taskYoutube.videoCount)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // MARK: Dates
                VStack(alignment: .leading, spacing: 8) {
                    if taskYoutube.taskStatus != .notStarted {
                        HStack {
                            Label("Start Date", systemImage: "calendar")
                            Spacer()
                            Text(taskYoutube.startDate!, style: .date)
                        }
                    }
                    
                    if taskYoutube.taskStatus == .completed {
                        HStack {
                            Label("Completed At", systemImage: "checkmark.circle")
                            Spacer()
                            Text(taskYoutube.completedAt!, style: .date)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // MARK: Expected Dates
                VStack(spacing: 8) {
                    HStack {
                        Label("Expected Start", systemImage: "calendar.badge.clock")
                        Spacer()
                        Text(taskYoutube.expectedStartDate!, style: .date)
                    }
                    HStack {
                        Label("Deadline", systemImage: "clock.fill")
                        Spacer()
                        Text(taskYoutube.expectedDeadline!, style: .date)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                // MARK: Action Buttons
                if taskYoutube.taskStatus == .notStarted {
                    Button("Start") {
                        // start logic
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                }
                
                if taskYoutube.taskStatus == .inProgress &&
                    taskYoutube.numVideosWatched == taskYoutube.videoCount {
                    Button("End") {
                        // end logic
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                }
            }
            .padding()
        }
    }
    
    // MARK: Status Label View
    private var statusLabel: some View {
        switch taskYoutube.taskStatus {
        case .notStarted:
            return Text("Not Started")
                .font(.subheadline.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.red)
                .cornerRadius(12)
        case .inProgress:
            return Text("In Progress")
                .font(.subheadline.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.yellow)
                .cornerRadius(12)
        case .completed:
            return Text("Completed")
                .font(.subheadline.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.green)
                .cornerRadius(12)
        }
    }
}

#Preview {
    PreviewContentMainHomeTaskYoutubeEditor()
}

struct PreviewContentMainHomeTaskYoutubeEditor: View {
    var body: some View {
        do {
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskYoutube = try TaskYoutubePlaylist.createInProgressYoutubePlaylist(
                playlistName: "HTML course",
                videoCount: 30,
                numVideosWatched: 10,
                linkToYoutube: "https://www.youtube.com/watch?v=8q0cyaYtzC4&t=901s",
                title: "watch this video",
                progress: 30,
                expectedStartDate: pastDate,
                startDate: pastDate,
                expectedDeadline: futureDate,
                taskStatus: .inProgress
            )
            
            return AnyView(MainHomeTaskYoutubeEditor(roadmap: Roadmap(), taskYoutube: taskYoutube))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
