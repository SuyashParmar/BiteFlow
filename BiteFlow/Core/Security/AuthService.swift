import Foundation

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws
    func logout()
    var isLoggedIn: Bool { get }
}

class AuthService: AuthServiceProtocol {
    static let shared = AuthService()
    
    private let sessionKey = "BiteFlow_SessionToken"
    
    var isLoggedIn: Bool {
        return KeychainManager.shared.load(key: sessionKey) != nil
    }
    
    func login(email: String, password: String) async throws {
        // Simulated network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        if email == "demo@biteflow.app" && password == "password123" {
            let token = "mock_token_12345"
            if let data = token.data(using: .utf8) {
                _ = KeychainManager.shared.save(key: sessionKey, data: data)
            }
        } else {
            throw NetworkError.unauthorized
        }
    }
    
    func logout() {
        KeychainManager.shared.delete(key: sessionKey)
    }
}
