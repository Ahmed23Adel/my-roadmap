//
//  DrawableConstants.swift
//  my roadmap
//
//  Created by ahmed on 03/08/2025.
//

import Foundation
import UIKit
/// A collection of constants used for positioning and sizing drawable elements on the screen.
///
/// `DrawableConstants` centralizes layout-related values such as screen dimensions,
/// element sizes, margins, and starting positions. This ensures consistent measurements
/// across the app and makes adjustments easier.
///
/// All values are static and read-only, meaning they can be accessed without creating
/// an instance of `DrawableConstants`.
///
/// Example usage:
/// ```swift
/// let width = DrawableConstants.width
/// let startX = DrawableConstants.startRoadmapX
/// ```
final class DrawableConstants {
    
    // MARK: - Screen Dimensions
    
    /// The full width of the device's main screen.
    static let screenWidth = UIScreen.main.bounds.width
    
    /// The full height of the device's main screen.
    static let screenHeight = UIScreen.main.bounds.height
    
    
    // MARK: - Element Sizes & Margins
    
    /// The default margin used for spacing elements.
    static let margin: CGFloat = 40
    
    /// The default drawable element width, calculated as half the screen width minus the margin.
    static let width: CGFloat = (screenWidth / 2) - margin
    
    /// The default drawable element height.
    static let height: CGFloat = 100
    
    
    // MARK: - Roadmap Starting Position
    
    /// The X-coordinate where the roadmap starts, set to the center of the screen.
    static let startRoadmapX: CGFloat = 0.50 * screenWidth
    
    /// The Y-coordinate where the roadmap starts, measured from the top of the screen.
    static let startRoadmapY: CGFloat = 35
    
    
    // MARK: - Image Sizes
    
    /// The default width for start images in the roadmap.
    static let startImgWidth: CGFloat = 100
    
    /// The default height for start images in the roadmap.
    static let startImgHeight: CGFloat = 100
    
    
    // MARK: - Canvas Dimensions
    
    /// The total width of the drawable canvas, set to match the screen width.
    static let canvasWidth: CGFloat = screenWidth
    
    /// The total height of the drawable canvas.
    static let canvasHeight: CGFloat = 3000
}
