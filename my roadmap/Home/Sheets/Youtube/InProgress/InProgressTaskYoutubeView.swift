//
//  InProgressTaskYoutubeView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct InProgressTaskYoutubeView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskYoutubePlaylist: TaskYoutubePlaylist
    @StateObject private var viewModel: InProgressTaskYoutubeViewModel
    
    init(roadmap: Roadmap, taskYoutubePlaylist: TaskYoutubePlaylist) {
        self.roadmap = roadmap
        self.taskYoutubePlaylist = taskYoutubePlaylist
        self._viewModel = StateObject(wrappedValue: InProgressTaskYoutubeViewModel(roadmap: roadmap, taskYoutubePlaylist: taskYoutubePlaylist))
    }
    
    var body: some View {
        VStack {
            // Status Section
            HStack {
                Text("Task Status")
                    .font(.headline)
                Spacer()
                Text("In Progress")
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.orange)
                    .cornerRadius(12)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
            
            // Youtube Playlist Information Section
            VStack(alignment: .leading, spacing: 8) {
                Label(taskYoutubePlaylist.playlistName, systemImage: "play.rectangle")
                    .font(.title3)
                
                Label(String(taskYoutubePlaylist.videoCount) + " videos", systemImage: "play.circle")
                    .font(.title3)
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
            
            // Videos Watched Section
            VStack {
                HStack {
                    Text("Videos Watched: ")
                        .font(.title2)
                    Spacer()
                    Text("\(taskYoutubePlaylist.numVideosWatched)")
                        .font(.title2)
                }
                
                // Video Update Controls
                HStack {
                    Text("Add videos:")
                        .font(.subheadline)
                    
                    HStack {
                        TextField("0", value: $viewModel.videosToAdd, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 60)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            viewModel.incrementVideosToAdd()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Button("Update") {
                        viewModel.updateVideosWatched()
                    }
                    .buttonStyle(.bordered)
                    .disabled(viewModel.videosToAdd <= 0)
                }
                
                HStack {
                    Text("Watching Progress: ")
                        .font(.title2)
                    Spacer()
                    Text("\(viewModel.watchingProgress)%")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
            
            // Dates Section
            VStack {
                HStack {
                    Text("Start date")
                        .font(.title2)
                    Spacer()
                    Text(taskYoutubePlaylist.startDate!, style: .date)
                        .font(.title2)
                }
                
                HStack {
                    Text("Expected deadline ")
                        .font(.title2)
                    Spacer()
                    Text(taskYoutubePlaylist.expectedDeadline!, style: .date)
                        .font(.title2)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
            
            // Action Button
            Button("Complete") {
                viewModel.completeTask()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    PreviewContentInProgressTaskYoutubeView()
}

struct PreviewContentInProgressTaskYoutubeView: View {
    var body: some View {
        do {
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            }
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskYoutubePlaylist = try TaskYoutubePlaylist.createInProgressYoutubePlaylist(
                playlistName: "SwiftUI Tutorial Series", videoCount: 400,
                numVideosWatched: 12,
                linkToYoutube: "https://youtube.com/playlist?list=example",
                title: "Learn SwiftUI",
                progress: 24,
                expectedStartDate: pastDate,
                startDate: pastDate,
                expectedDeadline: futureDate,
                taskStatus: .inProgress)
            
            let roadmap = Roadmap()
            roadmap.append(taskYoutubePlaylist)
            return AnyView(InProgressTaskYoutubeView(roadmap: roadmap, taskYoutubePlaylist: taskYoutubePlaylist))
        } catch {
            return AnyView(Text("Preview Error: \(error)")
                .foregroundColor(.red))
        }
    }
}
