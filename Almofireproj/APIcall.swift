// Alamofire's modern async-await way (Swift 5.5+)
import Alamofire

class APIService {
    // Using async-await (Alamofire supports this beautifully)
    func fetchPosts() async throws -> [Posts] {
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        let posts = try await AF.request(url)
            .validate()
            .serializingDecodable([Posts].self)
            .value
        
        return posts
    }
}
