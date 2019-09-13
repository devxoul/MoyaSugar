import struct Foundation.URL
import XCTest

import Moya
import MoyaSugar
import Then

fileprivate struct Endpoints<Target: SugarTargetType> {
  let sugar: Endpoint
  let moya: Endpoint

  init(_ target: Target) {
    self.sugar = MoyaSugarProvider<Target>().endpoint(target)
    self.moya = MoyaProvider<Target>().endpoint(target)
  }
  
  func `do`(_ closure: (Endpoint, Endpoint) -> Void) {
    return closure(self.moya, self.sugar)
  }
}

class MoyaSugarProviderTests: XCTestCase {

  func testMoyaSugarProvider() {
    GitHubAPI.url("https://api.github.com/user/devxoul/repos?page=2").do {
      Endpoints($0).do { moya, sugar in
        XCTAssertEqual(moya.url, "https://api.github.com/https://api.github.com/user/devxoul/repos%3Fpage=2")
        XCTAssertEqual(sugar.url, "https://api.github.com/user/devxoul/repos?page=2")
        XCTAssertEqual(moya.method, sugar.method)
        XCTAssertTrue({
          if case .requestPlain = moya.task {
            return true
          } else {
            return false
          }
        }())
        XCTAssertEqual(sugar.httpHeaderFields?["Accept"], "application/json")
        XCTAssertEqual(sugar.httpHeaderFields?.count, 1)
      }
    }
    GitHubAPI.userRepos(owner: "devxoul").do {
      Endpoints($0).do { moya, sugar in
        XCTAssertEqual(moya.url, sugar.url)
        XCTAssertEqual(moya.method, sugar.method)
        XCTAssertTrue({
          if case .requestPlain = moya.task {
            return true
          } else {
            return false
          }
        }())
        XCTAssertEqual(sugar.httpHeaderFields?["Accept"], "application/json")
        XCTAssertEqual(sugar.httpHeaderFields?.count, 1)
      }
    }
    GitHubAPI.createIssue(owner: "devxoul", repo: "MoyaSugar", title: "Title", body: nil).do {
      Endpoints($0).do { moya, sugar in
        XCTAssertEqual(moya.url, sugar.url)
        XCTAssertEqual(moya.method, sugar.method)
        guard case let .requestParameters(moyaParameters, moyaEncoding) = moya.task else { preconditionFailure() }
        guard case let .requestParameters(sugarParameters, sugarEncoding) = sugar.task else { preconditionFailure() }
        XCTAssertEqual(String(describing: moyaParameters), String(describing: sugarParameters))
        XCTAssertEqual(moyaEncoding is JSONEncoding, true)
        XCTAssertEqual(sugarEncoding is JSONEncoding, true)
        XCTAssertEqual(sugar.httpHeaderFields?["Accept"], "application/json")
        XCTAssertEqual(sugar.httpHeaderFields?.count, 1)
      }
    }
    GitHubAPI.editIssue(owner: "devxoul", repo: "Then", number: 1, title: "A", body: "B").do {
      Endpoints($0).do { moya, sugar in
        XCTAssertEqual(moya.url, sugar.url)
        XCTAssertEqual(moya.method, sugar.method)
        guard case let .requestParameters(moyaParameters, moyaEncoding) = moya.task else { preconditionFailure() }
        guard case let .requestParameters(sugarParameters, sugarEncoding) = sugar.task else { preconditionFailure() }
        XCTAssertEqual(moyaParameters.map { "\($0)" }.sorted(), sugarParameters.map { "\($0)" }.sorted())
        XCTAssertEqual(moyaEncoding is URLEncoding, true)
        XCTAssertEqual(sugarEncoding is URLEncoding, true)
        XCTAssertEqual(sugar.httpHeaderFields?["Accept"], "application/json")
        XCTAssertEqual(sugar.httpHeaderFields?.count, 1)
      }
    }
  }

  func testHTTPHeaderFields_overridedByEndpointClosure() {
    let endpointClosure: (GitHubAPI) -> Endpoint = { target in
      let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
      return defaultEndpoint.adding(newHTTPHeaderFields: ["Authorization": "MySecretToken"])
    }
    let provider = MoyaSugarProvider<GitHubAPI>(endpointClosure: endpointClosure)
    let endpoint = provider.endpoint(GitHubAPI.userRepos(owner: "devxoul"))
    XCTAssertNotNil(endpoint.httpHeaderFields)
    XCTAssertEqual(endpoint.httpHeaderFields!, [
      "Authorization": "MySecretToken",
      "Accept": "application/json",
    ])
  }
}
