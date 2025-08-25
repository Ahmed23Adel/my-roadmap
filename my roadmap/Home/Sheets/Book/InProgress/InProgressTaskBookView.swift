//
//  InProgressTaskBookView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI
//
//  InProgressTaskBookView.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

// MARK: - In Progress View
struct InProgressTaskBookView: View { // START STRUCT InProgressTaskBookView
    @ObservedObject var roadmap: Roadmap
    @ObservedObject var taskBook: TaskBook
    @StateObject private var viewModel: InProgressTaskBookViewModel
    
    init(roadmap: Roadmap, taskBook: TaskBook) { // START INIT
        self.roadmap = roadmap
        self.taskBook = taskBook
        self._viewModel = StateObject(wrappedValue: InProgressTaskBookViewModel(roadmap: roadmap, taskBook: taskBook))
    } // END INIT
    
    var body: some View { // START BODY
        VStack { // START VSTACK main
            // Status Section
            HStack { // START HSTACK status
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
            } // END HSTACK status
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
            
            // Book Information Section
            VStack { // START VSTACK book_info
                HStack { // START HSTACK book_name
                    Text("Book Name: ")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.bookName)
                        .font(.title2)
                } // END HSTACK book_name
                
                HStack { // START HSTACK total_pages
                    Text("Total Pages: ")
                        .font(.title2)
                    Spacer()
                    Text("\(taskBook.numPagesInBook)")
                        .font(.title2)
                } // END HSTACK total_pages
                
                VStack { // START VSTACK pages_read_section
                    HStack { // START HSTACK pages_read
                        Text("Pages Read: ")
                            .font(.title2)
                        Spacer()
                        Text("\(taskBook.numPagesRead)")
                            .font(.title2)
                    } // END HSTACK pages_read
                    
                    // Page Update Controls
                    HStack { // START HSTACK page_controls
                        Text("Add pages:")
                            .font(.subheadline)
                        
                        HStack { // START HSTACK increment_control
                            
                            TextField("0", value: $viewModel.pagesToAdd, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 60)
                                .multilineTextAlignment(.center)
                            
                            Button { // START BUTTON increment
                                viewModel.incrementPagesToAdd()
                            } label: { // START LABEL increment
                                Image(systemName: "plus")
                                    .foregroundColor(.blue)
                            } // END LABEL increment
                        } // END HSTACK increment_controls
                        
                        Button("Update") { // START BUTTON update
                            viewModel.updatePagesRead()
                        } // END BUTTON update
                        .buttonStyle(.bordered)
                        .disabled(viewModel.pagesToAdd <= 0)
                    } // END HSTACK page_controls
                } // END VSTACK pages_read_section
                
                HStack { // START HSTACK reading_progress
                    Text("Reading Progress: ")
                        .font(.title2)
                    Spacer()
                    Text("\(viewModel.readingProgress)%")
                        .font(.title2)
                        .foregroundColor(.blue)
                } // END HSTACK reading_progress
            } // END VSTACK book_info
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
            
            // Dates Section
            VStack { // START VSTACK dates_section
                HStack { // START HSTACK start_date
                    Text("Start date")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.startDate!, style: .date)
                        .font(.title2)
                } // END HSTACK start_date
                
                HStack { // START HSTACK expected_deadline
                    Text("Expected deadline ")
                        .font(.title2)
                    Spacer()
                    Text(taskBook.expectedDeadline!, style: .date)
                        .font(.title2)
                } // END HSTACK expected_deadline
            } // END VSTACK dates_section
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
            
            // Action Button
            Button("Complete") { // START BUTTON complete
                viewModel.completeTask()
            } // END BUTTON complete
            .buttonStyle(.borderedProminent)
            
            Spacer()
        } // END VSTACK main
        .padding()
    } // END BODY
} // END STRUCT InProgressTaskBookView

#Preview {
    PreviewContentInProgressTaskBookView()
}

struct PreviewContentInProgressTaskBookView: View { // START STRUCT PreviewContentInProgressTaskBookView
    var body: some View { // START BODY preview
        do { // START DO
            var pastDate: Date { // START VAR pastDate
                return Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            } // END VAR pastDate
            var futureDate: Date { // START VAR futureDate
                return Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            } // END VAR futureDate
            
            let taskBook = try TaskBook.createInProgressBook(
                bookName: "Clean code",
                numPagesInBook: 300,
                numPagesRead: 12,
                title: "Read book",
                progress: 30,
                expectedStartDate: pastDate,
                startDate: pastDate,
                expectedDeadline: futureDate,
                taskStatus: .inProgress)
            
            let roadmap = Roadmap()
            roadmap.append(taskBook)
            return AnyView(InProgressTaskBookView(roadmap: roadmap , taskBook: taskBook))
        } catch { // START CATCH
            return AnyView(Text("Preview Error: \(error)")
                .foregroundColor(.red))
        } // END CATCH
    } // END BODY preview
} // END STRUCT PreviewContentInProgressTaskBookView
