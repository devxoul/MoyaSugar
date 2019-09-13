import XCTest

import Moya
import MoyaSugar

class MoyaSugarTests: XCTestCase {

  func testRouteMethod() {
    XCTAssertEqual(Route.get("/path").method, Moya.Method.get)
    XCTAssertEqual(Route.post("/path").method, Moya.Method.post)
    XCTAssertEqual(Route.put("/path").method, Moya.Method.put)
    XCTAssertEqual(Route.delete("/path").method, Moya.Method.delete)
    XCTAssertEqual(Route.options("/path").method, Moya.Method.options)
    XCTAssertEqual(Route.head("/path").method, Moya.Method.head)
    XCTAssertEqual(Route.patch("/path").method, Moya.Method.patch)
    XCTAssertEqual(Route.trace("/path").method, Moya.Method.trace)
    XCTAssertEqual(Route.connect("/path").method, Moya.Method.connect)
  }

  func testRoutePath() {
    XCTAssertEqual(Route.get("/path").path, "/path")
    XCTAssertEqual(Route.post("/path").path, "/path")
    XCTAssertEqual(Route.put("/path").path, "/path")
    XCTAssertEqual(Route.delete("/path").path, "/path")
    XCTAssertEqual(Route.options("/path").path, "/path")
    XCTAssertEqual(Route.head("/path").path, "/path")
    XCTAssertEqual(Route.patch("/path").path, "/path")
    XCTAssertEqual(Route.trace("/path").path, "/path")
    XCTAssertEqual(Route.connect("/path").path, "/path")
  }
}
