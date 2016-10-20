//
//  Parameters.swift
//  MoyaSugar
//
//  Created by Suyeol Jeon on 17/10/2016.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import Alamofire
import Moya

/// `Parameters` has parameter encoding and values. Use `=>` operator for syntactic sugar.
///
/// Example:
///
/// ```
/// JSONEncoding() => [
///   "key1": "value1"
///   "key2": "value2"
/// ]
/// ```
public struct Parameters {
  public var encoding: Alamofire.ParameterEncoding
  public var values: [String: Any]

  public init(encoding: Alamofire.ParameterEncoding, values: [String: Any]) {
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
    self.init(encoding: Alamofire.URLEncoding(), values: values)
  }
}

infix operator =>

public func => (encoding: Alamofire.ParameterEncoding, values: [String: Any]) -> Parameters {
  return Parameters(encoding: encoding, values: values)
}
