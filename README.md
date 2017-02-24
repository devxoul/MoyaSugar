# MoyaSugar

![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Build Status](https://travis-ci.org/devxoul/MoyaSugar.svg?branch=master)](https://travis-ci.org/devxoul/MoyaSugar)
[![CocoaPods](http://img.shields.io/cocoapods/v/MoyaSugar.svg)](https://cocoapods.org/pods/MoyaSugar)

Syntactic sugar for Moya.

## Why?

[Moya](https://github.com/Moya/Moya) is an elegant network abstraction layer which abstracts API endpoints gracefully with `enum`. However, it would become massive when the application is getting larger. **Whenever you add an endpoint, you should write code at least 5 places: enum case, `method`, `path`, `parameters` and `parameterEncoding` property.** It makes you scroll down again and again. Besides, if you would like to set different HTTP header fields, you should customize `endpointClosure` of `MoyaProvider`.

If you're as lazy as I am, MoyaSugar is for you.

## At a Glance

Forget about `method`, `path`, `parameters`, `parameterEncoding` and `endpointClosure`. Use `route`, `params`, `httpHeaderFields` instead.

```swift
extension MyService: SugarTargetType {
  var route: Route {
    return .get("/me")
  }

  var params: Parameters? {
    return JSONEncoding() => [
      "username": "devxoul",
      "password": "****",
    ]
  }

  var httpHeaderFields: [String: String]? {
    return ["Accept": "application/json"]
  }
}
```

Use `MoyaSugarProvider` instead of `MoyaProvider`.

```swift
let provider = MoyaSugarProvider<MyService>()
let provider = RxMoyaSugarProvider<MyService>() // If you're using Moya/RxSwift
```

## Complete Example

```swift
import Moya
import Moyasugar

enum GitHubAPI {
  case url(String)
  case userRepos(owner: String)
  case createIssue(owner: String, repo: String, title: String, body: String?)
  case editIssue(owner: String, repo: String, number: Int, title: String?, body: String?)
}

extension GitHubAPI : SugarTargetType {

  /// method + path
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
  
  /// encoding + parameters
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
      // Use `URLEncoding()` as default when not specified
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

}
```

## APIs

- <a name="api-sugartargettype" href="#api-sugartargettype">🔗</a> **`protocol SugarTargetType`**

    ```diff
    - extension GitHubAPI: TargetType
    + extension GitHubAPI: SugarTargetType
    ```

- <a name="api-route" href="#api-route">🔗</a> **`var route: Route`**

    Returns `Route` which contains HTTP method and URL path information.

    ```diff
    - var method: Method { get }
    - var path: String { get }
    + var route: Route { get }
    ```

    Example:

    ```swift
    var route: Route {
      return .get("/me")
    }
    ```

- <a name="api-url" href="#api-url">🔗</a> **`var url: URL`**

    Returns the request URL. It retuens `defaultURL` as default, which is the combination of `baseURL` and `path`. Implement this property to return custom url. See [#6](https://github.com/devxoul/MoyaSugar/pull/6) for detail.


- <a name="api-params" href="#api-params">🔗</a> **`var params: Params?`**

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

- <a name="api-httpheaderfields" href="#api-httpheaderfields">🔗</a> **`var httpHeaderField: [String: String]?`**

    Returns HTTP header values. `nil` for default.

    Example:

    ```swift
    var httpHeaderFields: [String: String]? {
      return ["Accept": "application/json"]
    }
    ```

    Note: If the `MoyaSugarProvider` is initialized with an `endpointClosure` parameter, HTTP header fields of `endpointClosure` will be used. This is how to extend the target's HTTP header fields in `endpointClosure`:

    ```swift
    let endpointClosure: (GitHubAPI) -> Endpoint<GitHubAPI> = { target in
      let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
      return defaultEndpoint
        .adding(newHTTPHeaderFields: target.httpHeaderFields ?? [:])
        .adding(newHTTPHeaderFields: ["Authorization": "MySecretToken"])
    }
    ```

## Requirements

Same with [Moya](https://github.com/Moya/Moya)

## Installation

- **Using [CocoaPods](https://cocoapods.org)**:

    ```ruby
    pod 'MoyaSugar', '~> 0.4'
    pod 'MoyaSugar/RxSwift', '~> 0.4' # Use with RxSwift
    ```

> MoyaSugar currently doesn't cupport Carthage and Swift Package Manager.

## License

**MoyaSugar** is under MIT license. See the [LICENSE](LICENSE) file for more info.
