import class Foundation.DispatchQueue

import Moya

/// `MoyaSugarProvider` overrides `parameterEncoding` and `httpHeaderFields` of the
/// `endpointClosure` with `SugarTargetType`. `MoyaSugarProvider` can be used only with
/// `SugarTargetType`.
open class MoyaSugarProvider<Target: SugarTargetType>: MoyaProvider<Target> {

  override public init(
    endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
    requestClosure: @escaping RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
    stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
    callbackQueue: DispatchQueue? = nil,
    session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
    plugins: [PluginType] = [],
    trackInflights: Bool = false
  ) {
    func sugarEndpointClosure(target: Target) -> Endpoint {
      let endpoint = endpointClosure(target)
      return Endpoint(
        url: target.url.absoluteString,
        sampleResponseClosure: endpoint.sampleResponseClosure,
        method: endpoint.method,
        task: endpoint.task,
        httpHeaderFields: endpoint.httpHeaderFields
      )
    }
    super.init(
      endpointClosure: sugarEndpointClosure,
      requestClosure: requestClosure,
      stubClosure: stubClosure,
      callbackQueue: callbackQueue,
      session: session,
      plugins: plugins,
      trackInflights: trackInflights
    )
  }
}
