import XCTest
import MoyaSugar
import Then

class MultiSugarTargetTests: XCTestCase {

  func testURL() {
    GitHubAPI.url("https://github.com/user/devxoul/repos?page=2").do {
      XCTAssertEqual(MultiSugarTarget($0).url, $0.url)
      XCTAssertEqual(MultiSugarTarget($0).defaultURL, $0.defaultURL)
    }
    GitHubAPI.index.do {
      XCTAssertEqual(MultiSugarTarget($0).url, $0.url)
    }
    GitHubAPI.userRepos(owner: "devxoul").do {
      XCTAssertEqual(MultiSugarTarget($0).path, $0.path)
      XCTAssertEqual(MultiSugarTarget($0).url, $0.url)
    }
    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do {
      XCTAssertEqual(MultiSugarTarget($0).path, $0.path)
      XCTAssertEqual(MultiSugarTarget($0).url, $0.url)
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do {
      XCTAssertEqual(MultiSugarTarget($0).path, $0.path)
      XCTAssertEqual(MultiSugarTarget($0).url, $0.url)
    }
  }

  func testMethod() {
    GitHubAPI.userRepos(owner: "devxoul").do {
      XCTAssertEqual(MultiSugarTarget($0).method, $0.method)
    }
    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do {
      XCTAssertEqual(MultiSugarTarget($0).method, $0.method)
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do {
      XCTAssertEqual(MultiSugarTarget($0).method, $0.method)
    }
  }

  func testTasks() {
    MultiSugarTarget(GitHubAPI.userRepos(owner: "devxoul")).do { target in
      XCTAssertTrue({
        if case .requestPlain = target.task {
          return true
        } else {
          return false
        }
      }())
    }
    MultiSugarTarget(GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil)).do { target in
      guard case let .requestParameters(parameters, encoding) = target.task else { preconditionFailure() }
      XCTAssertTrue(encoding is JSONEncoding)
      XCTAssertEqual(parameters.count, 1)
      XCTAssertEqual(parameters["title"] as? String, "Title")
      XCTAssertNil(parameters["body"])
    }
    MultiSugarTarget(GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B")).do { target in
      guard case let .requestParameters(parameters, encoding) = target.task else { preconditionFailure() }
      XCTAssertTrue(encoding is URLEncoding)
      XCTAssertEqual(parameters.count, 2)
      XCTAssertEqual(parameters["title"] as? String, "A")
      XCTAssertEqual(parameters["body"] as? String, "B")
    }
  }

  func testHTTPHeaderFields() {
    GitHubAPI.userRepos(owner: "devxoul").do {
      XCTAssertEqual(MultiSugarTarget($0).headers, $0.headers)
    }
    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do {
      XCTAssertEqual(MultiSugarTarget($0).headers, $0.headers)
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do {
      XCTAssertEqual(MultiSugarTarget($0).headers, $0.headers)
    }
  }
}

extension MultiSugarTarget: Then {
}
