//
//  ExpectedDatesSection.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct ExpectedDatesSection: View {
    let taskArticle: TaskArticle
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Label("Expected Start", systemImage: "calendar.badge.clock")
                Spacer()
                Text(taskArticle.expectedStartDate!, style: .date)
            }
            HStack {
                Label("Deadline", systemImage: "clock.fill")
                Spacer()
                Text(taskArticle.expectedDeadline!, style: .date)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
    }
}

//#Preview {
//    ExpectedDatesSection()
//}
