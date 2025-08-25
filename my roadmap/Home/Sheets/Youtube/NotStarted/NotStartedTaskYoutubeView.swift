//
//  NotStartedTaskYoutubeView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI


struct NotStartedTaskYoutubeView: View {
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskYoutubePlaylist: TaskYoutubePlaylist
    
    @StateObject private var viewModel: NotStartedTaskYoutubeViewModel
    
    init(roadmap: Roadmap, taskYoutubePlaylist: TaskYoutubePlaylist){
        self.roadmap = roadmap
        self.taskYoutubePlaylist = taskYoutubePlaylist
        self._viewModel = StateObject(wrappedValue: NotStartedTaskYoutubeViewModel(roadmap: roadmap, taskYoutube: taskYoutubePlaylist))
    }
    
    var body: some View {
        ScrollView{
            
            
            VStack { // START: main VStack
                Group { // START: Group for status
                    HStack {
                        Text("Task Status")
                            .font(.headline)
                        Spacer()
                        Text("Not Started")
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                } // END: Group for status
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Label(taskYoutubePlaylist.playlistName, systemImage: "doc.text")
                        .font(.title3)
                    
                    Label(String(taskYoutubePlaylist.numVideosWatched) + " pages", systemImage: "number")
                        .font(.title3)
                    
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
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
                
                
                VStack(spacing: 8) {
                    HStack {
                        Label("Expected Start", systemImage: "calendar.badge.clock")
                        Spacer()
                        Text(taskYoutubePlaylist.expectedStartDate!, style: .date)
                    }
                    HStack {
                        Label("Deadline", systemImage: "clock.fill")
                        Spacer()
                        Text(taskYoutubePlaylist.expectedDeadline!, style: .date)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                
                
                if viewModel.isPrevTaskCompleted() {
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Ready to Start", systemImage: "play.circle")
                                .font(.title3)
                                .foregroundColor(.blue)
                            
                            Text("Click the start button when you're ready to begin working on this task.")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                        
                        Button("Start Task") {
                            viewModel.startTask()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.top)
                    }
                } else {
                    VStack {
                        Text("Please finish previous tasks to start this one")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }

                
            } // END: main VStack
            .padding()
        }
    }
}




#Preview {
    PreviewContentNotStartedTaskYoutubeView()
}

struct PreviewContentNotStartedTaskYoutubeView: View {
    var body: some View {
        do {
            var pastDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            var futureDate: Date {
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            }
            
            let taskYoutubePlaylist = try TaskYoutubePlaylist.createNotStartedYoutubePlaylist(
                playlistName: "create any",
                videoCount: 30,
                linkToYoutube: "https://www.youtube.com/watch?v=x1IsFLM2ZmM",
                title: "watch",
                expectedStartDate: futureDate,
                expectedDeadline: futureDate)
            
            let roadmap = Roadmap()
            roadmap.append(taskYoutubePlaylist)
            return AnyView(NotStartedTaskYoutubeView(roadmap: roadmap , taskYoutubePlaylist: taskYoutubePlaylist))
        } catch {
            return AnyView(Text("Preview Error: \(error)")
                .foregroundColor(.red))
        }
    }
}

