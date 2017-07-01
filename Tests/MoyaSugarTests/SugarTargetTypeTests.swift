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

  func testParams() {
    GitHubAPI.userRepos(owner: "devxoul").do {
      XCTAssertNil($0.params)
      XCTAssertNil($0.parameters)
    }

    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do {
      XCTAssertTrue($0.params?.encoding is JSONEncoding)
      XCTAssertEqual($0.parameters?.count, 1)
      XCTAssertEqual($0.parameters?["title"] as? String, "Title")
      XCTAssertNil($0.parameters?["body"])
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do {
      XCTAssertTrue($0.params?.encoding is URLEncoding)
      XCTAssertEqual($0.parameters?.count, 2)
      XCTAssertEqual($0.parameters?["title"] as? String, "A")
      XCTAssertEqual($0.parameters?["body"] as? String, "B")
    }
  }

  func testHTTPHeaderFields() {
    GitHubAPI.userRepos(owner: "devxoul").do {
      XCTAssertEqual($0.httpHeaderFields?.count, 1)
      XCTAssertEqual($0.httpHeaderFields?["Accept"], "application/json")
    }
    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do {
      XCTAssertEqual($0.httpHeaderFields?.count, 1)
      XCTAssertEqual($0.httpHeaderFields?["Accept"], "application/json")
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do {
      XCTAssertEqual($0.httpHeaderFields?.count, 1)
      XCTAssertEqual($0.httpHeaderFields?["Accept"], "application/json")
    }
  }

}
