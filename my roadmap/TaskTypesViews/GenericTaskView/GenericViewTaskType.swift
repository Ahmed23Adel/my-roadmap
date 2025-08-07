//
//  ViewTaskTypeBook.swift
//  my roadmap
//
//  Created by ahmed on 31/07/2025.
//

import SwiftUI

struct GenericViewTaskType: View {
    var taskBook: TaskObject
    @StateObject var viewModel: GenericViewModelTaskType
    private var Tasklabel: String
    private var imgName: String
    
    init(taskBook: TaskObject, Tasklabel: String, imgName: String) {
        self.taskBook = taskBook
        self._viewModel = StateObject(wrappedValue: GenericViewModelTaskType(taskBook: taskBook))
        self.Tasklabel = Tasklabel
        self.imgName = imgName
    }

    var body: some View {
        ZStack{ //START ZSTACK
            Image("texture")
                .resizable()
                .frame(width: DrawableConstants.width, height: DrawableConstants.height)
                .cornerRadius(20)
            
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                .stroke(lineWidth: 15)
                .frame(width: DrawableConstants.width, height: DrawableConstants.height)
                .foregroundColor(.green)
                .clipShape(
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                        .trim(from: 0, to: CGFloat(viewModel.getProgressFraction()))
                )
            
            VStack{ //START VSTACK for bookicon
                HStack{ //START HStack for bookicon
                    
//                    Text(" \(Int(taskBook.posX)) \(Int(taskBook.posY))")
                    Text(Tasklabel)
                        .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                        .font(.title2)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 25)
                    
                    Spacer()
                    Image(imgName)
                     .resizable()
                     .frame(width: 50, height: 50)
                }//END HStack for bookicon
                Spacer()
                
            }//END VSTACK for bookicon
               
            
        } //END ZSTACK
        .frame(width: DrawableConstants.width + DrawableConstants.margin, height: DrawableConstants.height + DrawableConstants.margin)
        .shadow(color: .black.opacity(0.3), radius: 10, x: -3, y: 3)
        
    }
}

#Preview {
    PreviewContent()
}

struct PreviewContent: View {
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
            let startDate = pastDate
            let taskBook = try TaskBook.createInProgressBook(
                bookName: "Clean code",
                numPagesInBook: 300,
                numPagesRead: 50,
                title: "Read book",
                progress: 50,
                expectedStartDate: pastDate,
                startDate: startDate,
                expectedDeadline: futureDate,
                taskStatus: .inProgress
            )
            return AnyView(GenericViewTaskType(taskBook: taskBook, Tasklabel: taskBook.bookName, imgName: "book"))
        } catch {
            return AnyView(Text("Preview Error: \(error.localizedDescription)")
                .foregroundColor(.red))
        }
    }
}
