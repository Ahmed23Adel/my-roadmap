//
//  TaskArticleInfoSection.swift
//  my roadmap
//
//  Created by ahmed on 25/08/2025.
//

import SwiftUI

struct TaskArticleInfoSection: View {
    let taskArticle: TaskArticle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(taskArticle.articleName, systemImage: "doc.text")
                .font(.title3)
            
            Button {
                if let url = URL(string: taskArticle.linkToArticle) {
                    UIApplication.shared.open(url)
                }
            } label: {
                Label("Open Article", systemImage: "arrow.up.right.square")
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
    }
}

//#Preview {
//    TaskArticleInfoSection()
//}
