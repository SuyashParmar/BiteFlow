import Foundation

struct CartItem: Identifiable, Equatable {
    let id: String
    let foodItem: FoodItem
    var quantity: Int
    
    var totalPrice: Double {
        return foodItem.price * Double(quantity)
    }
}

class CartManager {
    static let shared = CartManager()
    
    @Published private(set) var items: [CartItem] = []
    
    func addItem(_ foodItem: FoodItem) {
        if let index = items.firstIndex(where: { $0.foodItem.id == foodItem.id }) {
            items[index].quantity += 1
        } else {
            // Check if from same restaurant
            if let existing = items.first, existing.foodItem.restaurantId != foodItem.restaurantId {
                // In a real app, prompt user to clear cart
                items.removeAll()
            }
            items.append(CartItem(id: UUID().uuidString, foodItem: foodItem, quantity: 1))
        }
    }
    
    func removeItem(_ id: String) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    var subtotal: Double {
        items.reduce(0) { $0 + $1.totalPrice }
    }
}
