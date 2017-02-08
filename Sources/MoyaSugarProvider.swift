//
//  MoyaSugarProvider.swift
//  MoyaSugar
//
//  Created by Suyeol Jeon on 17/10/2016.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import Moya

/// `MoyaSugarProvider` overrides `parameterEncoding` and `httpHeaderFields` of the
/// `endpointClosure` with `SugarTargetType`. `MoyaSugarProvider` can be used only with
/// `SugarTargetType`.
open class MoyaSugarProvider<Target: SugarTargetType>: MoyaProvider<Target> {

  override public init(
    endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
    requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
    stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
    manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
    plugins: [PluginType] = [],
    trackInflights: Bool = false
  ) {
    func sugarEndpointClosure(target: Target) -> Endpoint<Target> {
      let endpoint = endpointClosure(target)
      return Endpoint<Target>(
        url: target.url.absoluteString,
        sampleResponseClosure: endpoint.sampleResponseClosure,
        method: endpoint.method,
        parameters: endpoint.parameters,
        parameterEncoding: endpoint.parameterEncoding,
        httpHeaderFields: endpoint.httpHeaderFields ?? target.httpHeaderFields 
      )
    }
    super.init(
      endpointClosure: sugarEndpointClosure,
      requestClosure: requestClosure,
      stubClosure: stubClosure,
      manager: manager,
      plugins: plugins,
      trackInflights: trackInflights
    )
  }

}
