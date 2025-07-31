//
//  HomeView.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        Text("home")
    }
}

#Preview {
    HomeView()
}
