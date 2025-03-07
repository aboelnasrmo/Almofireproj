//
//  FancyContentView.swift
//  Almofireproj
//
//  Created by Mohammad Aboelnasr on 07/03/2025.
//

import SwiftUI
import FancyScrollView
struct FancyPostView: View {
    @StateObject private var viewModel = PostViewModel()

    var body: some View {
        NavigationView {
            FancyScrollView(
              title: "Fancy Posts 🚀",
                headerHeight: 100,
                scrollUpHeaderBehavior: .parallax,
                scrollDownHeaderBehavior: .offset,
                header: {
                    Image("header_image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            ) {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.posts) { post in
                        postCard(post)
                    }
                }
                .padding()
            }
            .onAppear {
                viewModel.loadPosts()
            }
        }
      
    }

    private func postCard(_ post: Posts) -> some View {
        VStack(alignment: .leading) {
            Text(post.title.capitalized)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)

            Divider().background(Color.white.opacity(0.5))

            Text(post.body)
                .foregroundColor(.white.opacity(0.9))
                .font(.subheadline)
                .lineLimit(6)

            Spacer()
        }
        .padding()
        .frame(width: .infinity, height: 350)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.cyan, .blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}
#Preview {
  FancyPostView()
}
