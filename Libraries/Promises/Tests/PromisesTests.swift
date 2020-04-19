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
        }.catch { _ in
            XCTFail("Catch should not be executed")
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(received, "hola")
    }
    
    func testCatch() {
        let exp = expectation(description: "Promise fulfills")
        var received: Foo?
        
        Promise<String, Foo> { future in
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .microseconds(2)) {
                future.reject(.bar)
            }
        }.catch {
            received = $0
            exp.fulfill()
        }.then { _ in
            XCTFail("Then should not be executed")
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(received)
    }
    
    func testMapValue() {
        let exp = expectation(description: "Promise fulfills")
        var last: String?
        
        Promise<Int, Foo> { future in
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .microseconds(2)) {
                future.fulfill(2)
            }
        }.then {
            "\($0)"
        }.then {
            last = $0
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(last, "2")
    }
    
    func testMapError() {
        let exp = expectation(description: "Promise fulfills")
        var received: Wraps?
        
        Promise<Int, Foo> { future in
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .microseconds(2)) {
                future.reject(.bar)
            }
        }.catch {
            Wraps.other($0)
        }.catch {
            received = $0
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(received, Wraps.other(.bar))
    }    
}

private enum Foo: Error, Equatable {
    case bar
}

private enum Wraps: Error, Equatable {
    case other(Foo)
}
