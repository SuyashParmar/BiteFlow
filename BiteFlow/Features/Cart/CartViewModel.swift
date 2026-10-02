import Foundation
import Combine

class CartViewModel {
    @Published private(set) var items: [CartItem] = []
    @Published private(set) var subtotal: Double = 0
    @Published private(set) var total: Double = 0
    
    private let calculator = CartCalculator()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        CartManager.shared.$items
            .sink { [weak self] newItems in
                self?.items = newItems
                self?.calculateTotals(items: newItems)
            }
            .store(in: &cancellables)
    }
    
    private func calculateTotals(items: [CartItem]) {
        subtotal = items.reduce(0) { $0 + $1.totalPrice }
        total = calculator.calculateTotal(subtotal: subtotal)
    }
    
    func checkout() {
        // Handle checkout logic
    }
}
