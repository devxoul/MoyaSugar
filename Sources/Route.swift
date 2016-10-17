//
//  Route.swift
//  MoyaSugar
//
//  Created by Suyeol Jeon on 17/10/2016.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import Moya

public enum Route {
  case GET(String)
  case POST(String)
  case PUT(String)
  case DELETE(String)
  case OPTIONS(String)
  case HEAD(String)
  case PATCH(String)
  case TRACE(String)
  case CONNECT(String)

  public var path: String {
    switch self {
    case .GET(let path): return path
    case .POST(let path): return path
    case .PUT(let path): return path
    case .DELETE(let path): return path
    case .OPTIONS(let path): return path
    case .HEAD(let path): return path
    case .PATCH(let path): return path
    case .TRACE(let path): return path
    case .CONNECT(let path): return path
    }
  }

  public var method: Moya.Method {
    switch self {
    case .GET: return .GET
    case .POST: return .POST
    case .PUT: return .PUT
    case .DELETE: return .DELETE
    case .OPTIONS: return .OPTIONS
    case .HEAD: return .HEAD
    case .PATCH: return .PATCH
    case .TRACE: return .TRACE
    case .CONNECT: return .CONNECT
    }
  }
}
