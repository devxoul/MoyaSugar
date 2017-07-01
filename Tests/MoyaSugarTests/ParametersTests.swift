import XCTest

import Moya
import MoyaSugar

class ParametersTests: XCTestCase {

  func testParametersEncoding() {
    XCTAssertTrue((URLEncoding() => [:]).encoding is URLEncoding)
    XCTAssertTrue((URLEncoding() => ["key": "value"]).encoding is URLEncoding)

    XCTAssertTrue((JSONEncoding() => [:]).encoding is JSONEncoding)
    XCTAssertTrue((JSONEncoding() => ["key": "value"]).encoding is JSONEncoding)

    XCTAssertTrue((PropertyListEncoding() => [:]).encoding is PropertyListEncoding)
    XCTAssertTrue((PropertyListEncoding() => ["key": "value"]).encoding is PropertyListEncoding)
  }

  func testParametersValue() {
    ({ params in
      XCTAssertEqual(params.values.count, 2)
      XCTAssertEqual(params.values["name"] as? String, "Suyeol Jeon")
      XCTAssertEqual(params.values["birthyear"] as? Int, 1995)
    })(URLEncoding() => ["name": "Suyeol Jeon", "birthyear": 1995])

    ({ params in
      XCTAssertEqual(params.values.count, 2)
      XCTAssertEqual(params.values["name"] as? String, "Suyeol Jeon")
      XCTAssertEqual(params.values["birthyear"] as? Int, 1995)
    })(JSONEncoding() => ["name": "Suyeol Jeon", "birthyear": 1995])

    ({ params in
      XCTAssertEqual(params.values.count, 2)
      XCTAssertEqual(params.values["name"] as? String, "Suyeol Jeon")
      XCTAssertEqual(params.values["birthyear"] as? Int, 1995)
    })(PropertyListEncoding() => ["name": "Suyeol Jeon", "birthyear": 1995])
  }

}
