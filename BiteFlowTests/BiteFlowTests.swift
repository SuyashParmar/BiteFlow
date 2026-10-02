import XCTest
@testable import BiteFlow

final class BiteFlowTests: XCTestCase {
    func testCartCalculator() {
        let calculator = CartCalculator()
        let total = calculator.calculateTotal(subtotal: 100, discount: 0)
        // 100 subtotal + 5 tax (5%) + 49 delivery fee = 154
        XCTAssertEqual(total, 154.0)
    }
}
