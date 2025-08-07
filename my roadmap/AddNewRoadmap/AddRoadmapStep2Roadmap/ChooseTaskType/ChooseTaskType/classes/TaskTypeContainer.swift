//
//  classTy[e.swift
//  my roadmap
//
//  Created by ahmed on 07/08/2025.
//

import Foundation
import Combine

class TaskTypeContainer: ObservableObject, Identifiable{
    internal var id = UUID()
    @Published private(set) var typeName: String
    @Published private(set) var iconName: String
    @Published private(set) var route: ChooseTaskTypeRoute
    
    init(typeName: String, iconName: String, route: ChooseTaskTypeRoute) {
        self.typeName = typeName
        self.iconName = iconName
        self.route = route
    }
    
    
}
