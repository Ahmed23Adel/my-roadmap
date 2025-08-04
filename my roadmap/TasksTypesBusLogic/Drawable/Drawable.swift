//
//  Drawable.swift
//  my roadmap
//
//  Created by ahmed on 03/08/2025.
//

import Foundation

protocol Drawable{
    var posX:CGFloat {get set}
    var posY:CGFloat {get set}
    
    func calcWidth()->CGFloat
    func calcHeight()->CGFloat
    
    func calcMarginedWidth()->CGFloat
    func calcMarginedHeight()->CGFloat
}
