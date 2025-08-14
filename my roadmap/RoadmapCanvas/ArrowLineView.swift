//
//  ArrowLineView.swift
//  my roadmap
//
//  Created by ahmed on 04/08/2025.
//

import SwiftUI

struct ArrowLineView: View {
    let start: CGPoint
    let end: CGPoint
    
    var body: some View {
        ZStack {
            // L-shaped line path (always ends vertical) - ORIGINAL LOGIC MAINTAINED
            Path { path in
                path.move(to: start)
                
                if abs(Int(end.x) - Int(start.x)) == 0 {
                    // Same X coordinate - draw straight vertical line
                    path.addLine(to: end)
                } else if abs(Int(end.y) - Int(start.y)) > 0 {
                    // Different X and Y - use L-shaped path with curves
                    let verticalDistance = end.y - start.y
                    let quarterVertical = start.y + (verticalDistance / 4)
                    let horizontalDistance = end.x - start.x
                    
                    let curveRadius: CGFloat = 20
                    
                    // Determine direction for proper curve placement
                    let goingRight = horizontalDistance > 0
                    let goingDown = verticalDistance > 0
                    
                    // Step 1: Vertical line (stop before corner for smoothness)
                    let preCorner1Y = goingDown ? quarterVertical - curveRadius : quarterVertical + curveRadius
                    let preCorner1 = CGPoint(x: start.x, y: preCorner1Y)
                    path.addLine(to: preCorner1)
                    
                    // Smooth curve from vertical to horizontal
                    let postCorner1X = goingRight ? start.x + curveRadius : start.x - curveRadius
                    let postCorner1 = CGPoint(x: postCorner1X, y: quarterVertical)
                    let control1 = CGPoint(x: start.x, y: quarterVertical)
                    path.addQuadCurve(to: postCorner1, control: control1)
                    
                    // Step 2: Horizontal line (stop before corner for smoothness)
                    let preCorner2X = goingRight ? end.x - curveRadius : end.x + curveRadius
                    let preCorner2 = CGPoint(x: preCorner2X, y: quarterVertical)
                    path.addLine(to: preCorner2)
                    
                    // Smooth curve from horizontal to vertical
                    let postCorner2Y = goingDown ? quarterVertical + curveRadius : quarterVertical - curveRadius
                    let postCorner2 = CGPoint(x: end.x, y: postCorner2Y)
                    let control2 = CGPoint(x: end.x, y: quarterVertical)
                    path.addQuadCurve(to: postCorner2, control: control2)
                    
                    // Step 3: Final vertical line to end
                    path.addLine(to: end)
                } else {
                    // Same Y coordinate - draw straight horizontal line
                    path.addLine(to: end)
                }
            }
            .stroke(Color.black, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            
            Image("arrowtip")
                .resizable()
                .frame(width: 20, height: 20)
                .position(x: end.x, y: end.y)
        }
    }
}

#Preview {
    ArrowLineView(start: CGPointMake(100, 10), end: CGPointMake(10, 100))
}
