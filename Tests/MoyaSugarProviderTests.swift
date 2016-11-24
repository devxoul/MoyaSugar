//
//  MoyaSugarProviderTests.swift
//  MoyaSugar
//
//  Created by Suyeol Jeon on 18/10/2016.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import XCTest

import Moya
import MoyaSugar
import Then

fileprivate struct Endpoints<Target: SugarTargetType>: Then {
  let sugar: Endpoint<Target>
  let moya: Endpoint<Target>

  init(_ target: Target) {
    self.sugar = MoyaSugarProvider<Target>().endpoint(target)
    self.moya = MoyaProvider<Target>().endpoint(target)
  }
}

class MoyaSugarProviderTests: XCTestCase {

  func testMoyaSugarProvider() {
    GitHubAPI.url("https://api.github.com/user/devxoul/repos?page=2").do {
      Endpoints($0).do {
        XCTAssertEqual($0.moya.URL, "https://api.github.com/https://api.github.com/user/devxoul/repos%3Fpage=2")
        XCTAssertEqual($0.sugar.URL, "https://api.github.com/user/devxoul/repos?page=2")
        XCTAssertEqual($0.moya.method, $0.sugar.method)
        XCTAssertEqual("\($0.moya.parameters)", "\($0.sugar.parameters)")
        XCTAssertEqual($0.sugar.parameterEncoding is URLEncoding, true)
        XCTAssertEqual($0.sugar.httpHeaderFields?["Accept"], "application/json")
        XCTAssertEqual($0.sugar.httpHeaderFields?.count, 1)
      }
    }
    GitHubAPI.userRepos(owner: "devxoul").do {
      Endpoints($0).do {
        XCTAssertEqual($0.moya.URL, $0.sugar.URL)
        XCTAssertEqual($0.moya.method, $0.sugar.method)
        XCTAssertEqual("\($0.moya.parameters)", "\($0.sugar.parameters)")
        XCTAssertEqual($0.sugar.parameterEncoding is URLEncoding, true)
        XCTAssertEqual($0.sugar.httpHeaderFields?["Accept"], "application/json")
        XCTAssertEqual($0.sugar.httpHeaderFields?.count, 1)
      }
    }
    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do {
      Endpoints($0).do {
        XCTAssertEqual($0.moya.URL, $0.sugar.URL)
        XCTAssertEqual($0.moya.method, $0.sugar.method)
        XCTAssertEqual("\($0.moya.parameters)", "\($0.sugar.parameters)")
        XCTAssertEqual($0.sugar.parameterEncoding is JSONEncoding, true)
        XCTAssertEqual($0.sugar.httpHeaderFields?["Accept"], "application/json")
        XCTAssertEqual($0.sugar.httpHeaderFields?.count, 1)
      }
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do {
      Endpoints($0).do {
        XCTAssertEqual($0.moya.URL, $0.sugar.URL)
        XCTAssertEqual($0.moya.method, $0.sugar.method)
        XCTAssertEqual("\($0.moya.parameters)", "\($0.sugar.parameters)")
        XCTAssertEqual($0.sugar.parameterEncoding is URLEncoding, true)
        XCTAssertEqual($0.sugar.httpHeaderFields?["Accept"], "application/json")
        XCTAssertEqual($0.sugar.httpHeaderFields?.count, 1)
      }
    }
  }

}
