import XCTest
@testable import Promises

final class PromisesTests: XCTestCase {
    
    func testThen() {
        let exp = expectation(description: "Promise fulfills")
        var received: String?
        
        Promise<String, Foo> { future in
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .microseconds(2)) {
                future.fulfill("hola")
            }
        }.then {
            received = $0
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(received, "hola")
    }

}

private enum Foo: Error, Equatable {
    case bar
}
