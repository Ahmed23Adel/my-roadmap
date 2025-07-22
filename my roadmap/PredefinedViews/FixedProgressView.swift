//
//  ProgressView.swift
//  my roadmap
//
//  Created by ahmed on 22/07/2025.
//

import SwiftUI

struct FixedProgressView: View {
    var body: some View {
        ZStack{
            Color.gray
                .ignoresSafeArea()
                ProgressView("Loading...")
        }
    }
}

#Preview {
    FixedProgressView()
}
