//
//  Drawable.swift
//  my roadmap
//
//  Created by ahmed on 03/08/2025.
//

import Foundation

/// A protocol that defines the basic properties and methods required for a drawable object.
///
/// Conforming types must specify their position and implement calculations
/// for dimensions, including margins.
///
/// This protocol is useful when you want multiple drawable entities (shapes, images, UI components)
/// to share a common interface for positioning and size calculation.
protocol Drawable {

    // MARK: - Position Properties
    
    /// The horizontal position of the drawable object.
    var posX: CGFloat { get set }
    
    /// The vertical position of the drawable object.
    var posY: CGFloat { get set }
    
    
    // MARK: - Size Calculations
    
    /// Calculates the width of the drawable object.
    ///
    /// - Returns: The width as a `CGFloat`.
    func calcWidth() -> CGFloat
    
    /// Calculates the height of the drawable object.
    ///
    /// - Returns: The height as a `CGFloat`.
    func calcHeight() -> CGFloat
    
    
    // MARK: - Size Calculations with Margins
    
    /// Calculates the width of the drawable object including margins.
    ///
    /// - Returns: The total width as a `CGFloat`, factoring in margins.
    func calcMarginedWidth() -> CGFloat
    
    /// Calculates the height of the drawable object including margins.
    ///
    /// - Returns: The total height as a `CGFloat`, factoring in margins.
    func calcMarginedHeight() -> CGFloat
}

