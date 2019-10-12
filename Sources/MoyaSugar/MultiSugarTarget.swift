import Foundation
import Moya

public enum MultiSugarTarget: SugarTargetType {
  case target(SugarTargetType)

  public init(_ target: SugarTargetType) {
    self = .target(target)
  }

  public var target: SugarTargetType {
    switch self {
    case let .target(target):
      return target
    }
  }

  public var baseURL: URL {
    return self.target.baseURL
  }

  public var url: URL {
    return self.target.url
  }

  public var defaultURL: URL {
    return self.target.defaultURL
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

  public var task: Task {
    return self.target.task
  }

  public var validationType: ValidationType {
    return self.target.validationType
  }

  public var sampleData: Data {
    return self.target.sampleData
  }
}
