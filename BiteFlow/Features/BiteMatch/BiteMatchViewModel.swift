import Foundation
import Combine

class BiteMatchViewModel {
    @Published private(set) var stack: [FoodItem] = []
    @Published var matchFound: FoodItem?
    
    func loadFoods() {
        // Shuffle demo foods to create the stack
        stack = DemoData.foods.shuffled()
    }
    
    func handleSwipe(left: Bool, on item: FoodItem) {
        if !left {
            // Right swipe = LIKE
            // In a real app, track user preferences or add to cart.
            // For now, we simulate finding a "Match"
            matchFound = item
        }
    }
}
