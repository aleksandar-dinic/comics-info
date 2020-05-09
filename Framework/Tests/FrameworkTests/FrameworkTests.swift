import XCTest
@testable import Framework

final class FrameworkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Framework().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
