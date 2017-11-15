import Alamofire
import Moya

/// `Parameters` has parameter encoding and values. Use `=>` operator for syntactic sugar.
///
/// Example:
///
/// ```
/// JSONEncoding() => [
///   "key1": "value1",
///   "key2": "value2",
///   "key3": nil,      // will be ignored
/// ]
/// ```
public struct Parameters {
  public var encoding: Alamofire.ParameterEncoding
  public var values: [String: Any]

  public init(encoding: Alamofire.ParameterEncoding, values: [String: Any?]) {
    self.encoding = encoding
    self.values = filterNil(values)
  }
}

extension Parameters: ExpressibleByDictionaryLiteral {
  public init(dictionaryLiteral elements: (String, Any?)...) {
    var values: [String: Any?] = [:]
    for (key, value) in elements {
      values[key] = value
    }
    self.init(encoding: Alamofire.URLEncoding(), values: values)
  }
}

infix operator =>

public func => (encoding: Alamofire.ParameterEncoding, values: [String: Any?]) -> Parameters {
  return Parameters(encoding: encoding, values: values)
}

/// Returns a new dictinoary by filtering out nil values.
private func filterNil(_ dictionary: [String: Any?]) -> [String: Any] {
  var newDictionary: [String: Any] = [:]
  for (key, value) in dictionary {
    guard let value = value else { continue }
    newDictionary[key] = value
  }
  return newDictionary
}
