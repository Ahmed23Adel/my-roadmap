//
//  HomeViewModel.swift
//  my roadmap
//
//  Created by ahmed on 31/07/2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    var mainCoordinator: Coordinator?
    var homeCoordinator: HomeCoordinator?
    @Published private var roadmap: Roadmap
    
    init(){
        let defaultRoadmapReader = DefaultRoadmapReader()
        roadmap = defaultRoadmapReader.read()
    }
    
    func setMainCoordinator(coordinator: Coordinator){
        self.mainCoordinator = coordinator
    }
    
    func setHomeCoordinator(coordinator: HomeCoordinator){
        self.homeCoordinator = coordinator
    }
    
    func getRoadmap() -> Roadmap{
//        let roadmap = Roadmap()
//        roadmap.initTestableRoadmap()
//        roadmap.calcEachTaskPosition()
//        return roadmap
        roadmap.calcEachTaskPosition()
        
        return roadmap
    }
    
    func getTaskBook() -> TaskBook{
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
        let taskBook = try! TaskBook.createInProgressBook(
            bookName: "Clean code",
            numPagesInBook: 300,
            numPagesRead: 50,
            title: "Read book",
            progress: 20, // Assuming 20% progress
            expectedStartDate: pastDate,
            startDate: startDate,
            expectedDeadline: futureDate,
            taskStatus: .inProgress
        )
        return taskBook
    }
    
    
    
    func getRoadmapName() -> String{
        "Testable Roadmap"
    }
    
    func navigateToAddNewRoadmap(){
        mainCoordinator?.navigateTo(.addNewRoadmap)
    }
    
    func navigateToSettings(){
        homeCoordinator?.push(.settings)
    }
    
    
}
