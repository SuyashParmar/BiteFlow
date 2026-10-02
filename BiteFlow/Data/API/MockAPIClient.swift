import Foundation

class MockAPIClient: APIClientProtocol {
    
    // Simulate network delay
    private let delay: TimeInterval = 1.0
    
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        
        let path = endpoint.path
        
        if path.contains("/restaurants") && !path.contains("/menu") {
            if path == "/restaurants" {
                return DemoData.restaurants as! T
            }
        }
        
        // Throw not found for unhandled endpoints
        throw NetworkError.notFound
    }
}
