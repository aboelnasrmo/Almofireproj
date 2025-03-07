//
//  ContentView.swift
//  Almofireproj
//
//  Created by Mohammad Aboelnasr on 07/03/2025.
//

import SwiftUI

// MARK: - SwiftUI View (MVVM)
struct ContentView: View {
    @StateObject private var viewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                VStack(alignment: .leading, spacing: 8) {
                    Text(post.title.capitalized)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(post.body)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("Alamofire Posts 🚀")
            .onAppear {
                viewModel.loadPosts()
            }
            .refreshable { // Optional: Pull-to-refresh support in SwiftUI
                viewModel.loadPosts()
            }
        }
    }
}

#Preview {
    ContentView()
}
