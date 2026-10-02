import Foundation

protocol RestaurantRepository {
    func fetchRestaurants() async throws -> [Restaurant]
    func fetchMenu(for restaurantId: String) async throws -> [FoodItem]
}
