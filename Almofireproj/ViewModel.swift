import SwiftUI

// MARK: - ViewModel (ObservableObject Class)
@MainActor
class PostViewModel: ObservableObject {
    @Published var posts = [Posts]()
    private let apiService = APIService()
    
    func loadPosts() {
        Task {
            do {
                posts = try await apiService.fetchPosts()
            } catch {
                print("❌ Error fetching posts:", error.localizedDescription)
            }
        }
    }
}
