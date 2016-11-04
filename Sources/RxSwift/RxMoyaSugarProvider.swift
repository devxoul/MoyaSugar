//
//  RxMoyaSugarProvider.swift
//  MoyaSugar
//
//  Created by Suyeol Jeon on 17/10/2016.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import Moya
import MoyaSugar

/// `MoyaSugarProvider` overrides `parameterEncoding` and `httpHeaderFields` of the
/// `endpointClosure` with `SugarTargetType`. `MoyaSugarProvider` can be used only with
/// `SugarTargetType`.
open class RxMoyaSugarProvider<Target: SugarTargetType>: RxMoyaProvider<Target> {

  override public init(
    endpointClosure: @escaping EndpointClosure = MoyaProvider.DefaultEndpointMapping,
    requestClosure: @escaping RequestClosure = MoyaProvider.DefaultRequestMapping,
    stubClosure: @escaping StubClosure = MoyaProvider.NeverStub,
    manager: Manager = RxMoyaProvider<Target>.DefaultAlamofireManager(),
    plugins: [PluginType] = [],
    trackInflights: Bool = false
  ) {
    func sugarEndpointClosure(target: Target) -> Endpoint<Target> {
      let endpoint = endpointClosure(target)
      return Endpoint<Target>(
        URL: endpoint.URL,
        sampleResponseClosure: endpoint.sampleResponseClosure,
        method: endpoint.method,
        parameters: endpoint.parameters,
        parameterEncoding: target.params?.encoding ?? endpoint.parameterEncoding,
        httpHeaderFields: target.httpHeaderFields ?? endpoint.httpHeaderFields
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
