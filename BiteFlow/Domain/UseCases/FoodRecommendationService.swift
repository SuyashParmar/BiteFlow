import Foundation

protocol FoodRecommendationService {
    func recommendFood(prompt: String) async throws -> [FoodItem]
}

class DemoFoodRecommendationService: FoodRecommendationService {
    func recommendFood(prompt: String) async throws -> [FoodItem] {
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        // Simple deterministic rule-based demo
        let lower = prompt.lowercased()
        
        var results = DemoData.foods
        
        if lower.contains("veg") && !lower.contains("non-veg") {
            results = results.filter { $0.isVeg }
        }
        
        if lower.contains("pizza") {
            results = results.filter { $0.name.lowercased().contains("pizza") }
        }
        
        if lower.contains("chicken") {
            results = results.filter { !$0.isVeg }
        }
        
        return Array(results.prefix(3))
    }
}
