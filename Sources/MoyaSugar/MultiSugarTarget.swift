import Foundation
import Moya

public enum MultiSugarTarget: SugarTargetType {
  case target(SugarTargetType)

  public var target: SugarTargetType {
    switch self {
    case let .target(target):
      return target
    }
  }

  public var baseURL: URL {
    return self.target.baseURL
  }

  public var route: Route {
    return self.target.route
  }

  public var parameters: Parameters? {
    return self.target.parameters
  }

  public var headers: [String: String]? {
    return self.target.headers
  }

  public var sampleData: Data {
    return self.target.sampleData
  }
}
