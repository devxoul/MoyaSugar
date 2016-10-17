//
//  SugarTargetType.swift
//  MoyaSugar
//
//  Created by Suyeol Jeon on 17/10/2016.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import Moya

public protocol SugarTargetType: TargetType {
  var url: URL { get }
  var route: Route { get }
  var params: Parameters? { get }
  var httpHeaderFields: [String: String]? { get }
}

public extension SugarTargetType {
  public var url: URL {
    return self.baseURL.appendingPathComponent(self.path)
  }

  public var path: String {
    return self.route.path
  }

  public var method: Moya.Method {
    return self.route.method
  }

  public var parameters: [String: Any]? {
    return self.params?.values
  }

  public var httpHeaderFields: [String: String]? {
    return nil
  }
}
