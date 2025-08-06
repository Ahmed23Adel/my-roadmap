//
//  DrawableConstants.swift
//  my roadmap
//
//  Created by ahmed on 03/08/2025.
//

import Foundation
import UIKit

final class DrawableConstants{
    static let screenWidth = UIScreen.main.bounds.width
   static let screenHeight = UIScreen.main.bounds.height
    
    static let width: CGFloat = (screenWidth/2) - margin
    static let height: CGFloat = 100
    static let margin: CGFloat = 40
    
    static let startRoadmapX: CGFloat = (0.50) * screenWidth
    static let startRoadmapY: CGFloat = 35
    
    
    static let startImgWidth: CGFloat = 100
    static let startImgHeight: CGFloat = 100
   
    static let canvasWidth: CGFloat = screenWidth
    static let canvasHeight: CGFloat = 3000
}
