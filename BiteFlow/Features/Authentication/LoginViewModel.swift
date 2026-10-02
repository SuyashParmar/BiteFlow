import Foundation
import Combine

class LoginViewModel {
    private let authService: AuthServiceProtocol
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let loginSuccess = PassthroughSubject<Void, Never>()
    
    init(authService: AuthServiceProtocol = AuthService.shared) {
        self.authService = authService
    }
    
    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                try await authService.login(email: email, password: password)
                await MainActor.run {
                    self.isLoading = false
                    self.loginSuccess.send()
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.errorMessage = "Invalid credentials. Try demo@biteflow.app / password123"
                }
            }
        }
    }
}
