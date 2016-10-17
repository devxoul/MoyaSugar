//
//  Parameters.swift
//  MoyaSugar
//
//  Created by Suyeol Jeon on 17/10/2016.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import Moya

public struct Parameters {
  public var encoding: ParameterEncoding
  public var values: [String: Any]

  public init(encoding: ParameterEncoding, values: [String: Any]) {
    self.encoding = encoding
    self.values = values
  }
}

extension Parameters: ExpressibleByDictionaryLiteral {
  public init(dictionaryLiteral elements: (String, Any)...) {
    var values: [String: Any] = [:]
    for (key, value) in elements {
      values[key] = value
    }
    self.init(encoding: URLEncoding(), values: values)
  }
}

infix operator =>

public func => (encoding: ParameterEncoding, values: [String: Any]) -> Parameters {
  return Parameters(encoding: encoding, values: values)
}
