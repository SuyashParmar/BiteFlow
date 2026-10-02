import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noInternet
    case timeout
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case decodingError
    case unknown
    case message(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noInternet:
            return "Please check your internet connection."
        case .timeout:
            return "The request timed out. Please try again."
        case .unauthorized:
            return "Please log in to continue."
        case .forbidden:
            return "You don't have permission to perform this action."
        case .notFound:
            return "The requested resource could not be found."
        case .serverError:
            return "Something went wrong on our end. Please try again later."
        case .decodingError:
            return "We encountered an issue processing the data."
        case .unknown:
            return "An unknown error occurred."
        case .message(let msg):
            return msg
        }
    }
}
