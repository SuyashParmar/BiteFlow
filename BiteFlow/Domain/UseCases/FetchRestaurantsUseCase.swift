import Foundation

protocol FetchRestaurantsUseCaseProtocol {
    var repository: RestaurantRepository { get }
    func execute() async throws -> [Restaurant]
}

class FetchRestaurantsUseCase: FetchRestaurantsUseCaseProtocol {
    let repository: RestaurantRepository
    
    init(repository: RestaurantRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Restaurant] {
        return try await repository.fetchRestaurants()
    }
}
