import struct Foundation.URL

import Moya

public protocol SugarTargetType: TargetType {
  var url: URL { get }

  /// Returns `Route` which contains HTTP method and URL path information.
  ///
  /// Example:
  ///
  /// ```
  /// var route: Route {
  ///   return .get("/me")
  /// }
  /// ```
  var route: Route { get }
}

public extension SugarTargetType {
  public var url: URL {
    return self.defaultURL
  }

  var defaultURL: URL {
    return self.path.isEmpty ? self.baseURL : self.baseURL.appendingPathComponent(self.path)
  }

  public var path: String {
    return self.route.path
  }

  public var method: Moya.Method {
    return self.route.method
  }
}
