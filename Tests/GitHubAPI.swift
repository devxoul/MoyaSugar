//
//  GitHubAPI.swift
//  MoyaSugar
//
//  Created by Suyeol Jeon on 18/10/2016.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import Moya
import MoyaSugar
import Then

enum GitHubAPI: SugarTargetType, Then {
  var baseURL: URL {
    return URL(string: "https://api.github.com")!
  }

  case url(String)
  case userRepos(owner: String)
  case createIssue(owner: String, repo: String, title: String, body: String?)
  case editIssue(owner: String, repo: String, number: Int, title: String?, body: String?)

  var route: Route {
    switch self {
    case .url(let urlString):
      return .get(urlString)

    case .userRepos(let owner):
      return .get("/users/\(owner)/repos")

    case .createIssue(let owner, let repo, _, _):
      return .post("/repos/\(owner)/\(repo)/issues")

    case .editIssue(let owner, let repo, let number, _, _):
      return .patch("/repos/\(owner)/\(repo)/issues/\(number)")
    }
  }

  var url: URL {
    switch self {
    case .url(let urlString):
      return URL(string: urlString)!
    default:
      return self.defaultURL
    }
  }

  var params: Parameters? {
    switch self {
    case .url:
      return nil

    case .userRepos:
      return nil

    case .createIssue(_, _, let title, let body):
      return JSONEncoding() => [
        "title": title,
        "body": body,
      ]

    case .editIssue(_, _, _, let title, let body):
      // to test default encoding
      return [
        "title": title,
        "body": body,
      ]
    }
  }

  var httpHeaderFields: [String: String]? {
    return [
      "Accept": "application/json"
    ]
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    return .request
  }
}
