//
//  Route.swift
//  MoyaSugar
//
//  Created by Suyeol Jeon on 17/10/2016.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import Moya

/// `Route` has HTTP method and URL path.
///
/// Example:
///
/// ```
/// .get("/me")
/// ```
public enum Route {
  case get(String)
  case post(String)
  case put(String)
  case delete(String)
  case options(String)
  case head(String)
  case patch(String)
  case trace(String)
  case connect(String)

  public var path: String {
    switch self {
    case .get(let path): return path
    case .post(let path): return path
    case .put(let path): return path
    case .delete(let path): return path
    case .options(let path): return path
    case .head(let path): return path
    case .patch(let path): return path
    case .trace(let path): return path
    case .connect(let path): return path
    }
  }

  public var method: Moya.Method {
    switch self {
    case .get: return .get
    case .post: return .post
    case .put: return .put
    case .delete: return .delete
    case .options: return .options
    case .head: return .head
    case .patch: return .patch
    case .trace: return .trace
    case .connect: return .connect
    }
  }
}
