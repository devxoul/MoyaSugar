import XCTest

import Moya
import MoyaSugar

class SugarTargetTypeTests: XCTestCase {

  func testURL() {
    GitHubAPI.url("https://github.com/user/devxoul/repos?page=2").do {
      XCTAssertEqual($0.url, URL(string: "https://github.com/user/devxoul/repos?page=2")!)
    }
    GitHubAPI.index.do {
      XCTAssertEqual($0.url, URL(string: "https://api.github.com")!)
    }
    GitHubAPI.userRepos(owner: "devxoul").do {
      XCTAssertEqual($0.path, "/users/devxoul/repos")
      XCTAssertEqual($0.url, URL(string: "https://api.github.com/users/devxoul/repos")!)
    }
    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do {
      XCTAssertEqual($0.path, "/repos/devxoul/MoyaSugar/issues")
      XCTAssertEqual($0.url, URL(string: "https://api.github.com/repos/devxoul/MoyaSugar/issues")!)
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do {
      XCTAssertEqual($0.path, "/repos/devxoul/Then/issues/1")
      XCTAssertEqual($0.url, URL(string: "https://api.github.com/repos/devxoul/Then/issues/1")!)
    }
  }

  func testMethod() {
    GitHubAPI.userRepos(owner: "devxoul").do {
      XCTAssertEqual($0.method, .get)
    }
    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do {
      XCTAssertEqual($0.method, .post)
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do {
      XCTAssertEqual($0.method, .patch)
    }
  }

  func testTasks() {
    GitHubAPI.userRepos(owner: "devxoul").do { target in
      XCTAssertTrue({
        if case .requestPlain = target.task {
          return true
        } else {
          return false
        }
      }())
    }
    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do { target in
      guard case let .requestParameters(parameters, encoding) = target.task else { preconditionFailure() }
      XCTAssertTrue(encoding is JSONEncoding)
      XCTAssertEqual(parameters.count, 1)
      XCTAssertEqual(parameters["title"] as? String, "Title")
      XCTAssertNil(parameters["body"])
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do { target in
      guard case let .requestParameters(parameters, encoding) = target.task else { preconditionFailure() }
      XCTAssertTrue(encoding is URLEncoding)
      XCTAssertEqual(parameters.count, 2)
      XCTAssertEqual(parameters["title"] as? String, "A")
      XCTAssertEqual(parameters["body"] as? String, "B")
    }
  }

  func testHTTPHeaderFields() {
    GitHubAPI.userRepos(owner: "devxoul").do {
      XCTAssertEqual($0.headers?.count, 1)
      XCTAssertEqual($0.headers?["Accept"], "application/json")
    }
    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do {
      XCTAssertEqual($0.headers?.count, 1)
      XCTAssertEqual($0.headers?["Accept"], "application/json")
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do {
      XCTAssertEqual($0.headers?.count, 1)
      XCTAssertEqual($0.headers?["Accept"], "application/json")
    }
  }
}
