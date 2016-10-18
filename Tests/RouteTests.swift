//
//  RouteTests.swift
//  MoyaSugar
//
//  Created by Suyeol Jeon on 17/10/2016.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import XCTest

import Moya
import MoyaSugar

class MoyaSugarTests: XCTestCase {

  func testRouteMethod() {
    XCTAssertEqual(Route.GET("/path").method, Moya.Method.GET)
    XCTAssertEqual(Route.POST("/path").method, Moya.Method.POST)
    XCTAssertEqual(Route.PUT("/path").method, Moya.Method.PUT)
    XCTAssertEqual(Route.DELETE("/path").method, Moya.Method.DELETE)
    XCTAssertEqual(Route.OPTIONS("/path").method, Moya.Method.OPTIONS)
    XCTAssertEqual(Route.HEAD("/path").method, Moya.Method.HEAD)
    XCTAssertEqual(Route.PATCH("/path").method, Moya.Method.PATCH)
    XCTAssertEqual(Route.TRACE("/path").method, Moya.Method.TRACE)
    XCTAssertEqual(Route.CONNECT("/path").method, Moya.Method.CONNECT)
  }

  func testRoutePath() {
    XCTAssertEqual(Route.GET("/path").path, "/path")
    XCTAssertEqual(Route.POST("/path").path, "/path")
    XCTAssertEqual(Route.PUT("/path").path, "/path")
    XCTAssertEqual(Route.DELETE("/path").path, "/path")
    XCTAssertEqual(Route.OPTIONS("/path").path, "/path")
    XCTAssertEqual(Route.HEAD("/path").path, "/path")
    XCTAssertEqual(Route.PATCH("/path").path, "/path")
    XCTAssertEqual(Route.TRACE("/path").path, "/path")
    XCTAssertEqual(Route.CONNECT("/path").path, "/path")
  }

}
