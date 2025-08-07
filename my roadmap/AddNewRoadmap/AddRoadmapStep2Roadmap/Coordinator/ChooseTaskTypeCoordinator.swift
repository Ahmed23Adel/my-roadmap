//
//  ChooseTaskTypeCoordinator.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import Foundation
import Combine
import SwiftUI

class ChooseTaskTypeCoordinator: ObservableObject{
    @Published var currentRoute: ChooseTaskTypeRoute = .chooseType
    
    
    func navigateTo(_ route: ChooseTaskTypeRoute){
        self.currentRoute = route
    }
    
    
}
