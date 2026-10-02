import XCTest

final class BiteFlowUITests: XCTestCase {
    func testAppLaunch() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.exists)
    }
}
