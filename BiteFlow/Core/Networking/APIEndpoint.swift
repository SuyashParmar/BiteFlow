import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension APIEndpoint {
    var baseURL: URL {
        // In demo mode this might not be used if we mock responses,
        // but it's here for realistic architecture.
        return URL(string: "https://api.biteflow.demo")!
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var urlRequest: URLRequest? {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else { return nil }
        
        if method == .GET, let params = parameters {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if method != .GET, let params = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }
        
        return request
    }
}
