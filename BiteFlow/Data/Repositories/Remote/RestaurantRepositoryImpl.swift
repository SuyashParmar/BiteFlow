import Foundation

class RestaurantRepositoryImpl: RestaurantRepository {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    struct RestaurantEndpoint: APIEndpoint {
        var path: String = "/restaurants"
        var method: HTTPMethod = .GET
        var parameters: [String: Any]? = nil
    }
    
    func fetchRestaurants() async throws -> [Restaurant] {
        let endpoint = RestaurantEndpoint()
        let dtos: [RestaurantDTO] = try await apiClient.request(endpoint)
        return dtos.map { RestaurantMapper.map(dto: $0) }
    }
    
    struct MenuEndpoint: APIEndpoint {
        let restaurantId: String
        var path: String { "/restaurants/\(restaurantId)/menu" }
        var method: HTTPMethod = .GET
        var parameters: [String: Any]? = nil
    }
    
    func fetchMenu(for restaurantId: String) async throws -> [FoodItem] {
        let endpoint = MenuEndpoint(restaurantId: restaurantId)
        let dtos: [FoodDTO] = try await apiClient.request(endpoint)
        return dtos.map { FoodMapper.map(dto: $0) }
    }
}
