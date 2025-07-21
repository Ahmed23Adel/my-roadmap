//
//  Sheet.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import Foundation

enum Sheet: Identifiable{
    case editProfile
    var id: String{
        switch self {
            case .editProfile:
            return "editProfile"
        }
    }
}
