# MoyaSugar

![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Build Status](https://travis-ci.org/devxoul/MoyaSugar.svg?branch=master)](https://travis-ci.org/devxoul/MoyaSugar)
[![CocoaPods](http://img.shields.io/cocoapods/v/MoyaSugar)](https://cocoapods.org/pods/MoyaSugar)

Syntactic sugar for Moya.

## At a Glance

```swift
import Moya
import Moyasugar

enum GitHubAPI {
  case userRepos(owner: String)
  case createIssue(owner: String, repo: String, title: String, body: String?)
  case editIssue(owner: String, repo: String, number: Int, title: String?, body: String?)
}

extension SugarTargetType {

  /// Method + Path
  var route: Route {
    switch self {
    case .userRepos(let owner):
      return .GET("/users/\(owner)/repos")

    case .createIssue(let owner, let repo, _, _):
      return .POST("/repos/\(owner)/\(repo)/issues")

    case .editIssue(let owner, let repo, let number, _, _):
      return .PATCH("/repos/\(owner)/\(repo)/issues/\(number)")
    }
  }
  
  /// Encoding + Parameter
  var params: Parameters? {
    switch self {
    case .userRepos:
      return nil

    case .createIssue(_, _, let title, let body):
      return JSONEncoding() => [
        "title": title,
        "body": body,
      ]

    case .editIssue(_, _, _, let title, let body):
      return /*(default) URLEncoding =>*/ [
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

}
```

## APIs

- **`protocol SugarTargetType`**

    ```diff
    - extension GitHubAPI: TargetType
    + extension GitHubAPI: SugarTargetType
    ```

- **`var route: Route`**

    Returns `Route` which contains HTTP method and URL path information.

    ```diff
    - var method: Method { get }
    - var path: String { get }
    + var route: Route { get }
    ```

    Example:

    ```swift
    var route: Route {
      return .GET("/me")
    }
    ```

- **`var params: Params?`**

    Returns `Parameters` which contains parameter encoding and values.

    ```diff
    - var parameters: [String: Any]? { get }
    + var params: Params? { get }
    ```
    
    Example:
   
    ```swift
    var params: Parameters? {
      return JSONEncoding() => [
        "username": "devxoul",
        "password": "****",
      ]
    }
    ```

- **`var httpHeaderField: [String: String]?`**

    Returns HTTP header values. `nil` for default.

    Example:

    ```swift
    var httpHeaderFields: [String: String]? {
     return ["Accept": "application/json"]
    }
    ```

## License

**MoyaSugar** is under MIT license. See the [LICENSE](LICENSE) file for more info.
