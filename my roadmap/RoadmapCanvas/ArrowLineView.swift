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
            // L-shaped line path (always ends vertical)
            Path { path in
                path.move(to: start)
                
                if abs(Int(end.y) - Int(start.y)) > 0 {
                    // Step 1: Go vertical for a quarter of the total vertical distance
                    let verticalDistance = end.y - start.y
                    let quarterVertical = start.y + (verticalDistance / 4)
                    let midUpperPoint = CGPoint(x: start.x, y: quarterVertical)
                    path.addLine(to: midUpperPoint)
                    
                    // Step 2: Go horizontal to end.x
                    let midPoint = CGPoint(x: end.x, y: quarterVertical)
                    path.addLine(to: midPoint)
                    
                    // Step 3: Go vertical for the rest (remaining 3/4) to end
                    path.addLine(to: end)
                } else {
                    // If no vertical distance, just draw straight horizontal
                    path.addLine(to: end)
                }
            }
            .stroke(Color.black, lineWidth: 2)
            
            Image("arrowtip")
                .resizable()
                .frame(width: 20, height: 20)
                .position(x: end.x, y: end.y)
        }
    }
}

#Preview {
    ArrowLineView(start: CGPointMake(10, 10), end: CGPointMake(100, 100))
}
