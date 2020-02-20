//
//  CybercourceBuilder.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation
import AHNetwork
import EitherResult

protocol CybersourceNetworkLayer {
    func sendRequest<T: Decodable>(of type: CybersourceReqeustType,
                                   completion: @escaping AHCallback<T>)
}

final class CybersourceNetworkLayerImp<Factory: CybersourceReqeustFactory>: CybersourceNetworkLayer where Factory.RequestType == CybersourceReqeustType {
    let networkLayer: GenericNetworkLayer<Factory>
    let builder = GenericNetworkLayerBuilder()
    
    init(factory: Factory) {
        networkLayer = builder.getNetworkLayer(using: factory)
        
    }
    
    public func sendRequest<T>(of type: CybersourceReqeustType,
                               completion: @escaping AHCallback<T>) where T: Decodable {
        networkLayer.sendRequest(of: type, completion: completion)
    }
}


public enum CybercourceEnvi {
    case test
    case prod
}

public class CybercourceBuilder {
    public enum Environment {
        case test
        case prod
    }
    
    public var httpSingnatureConfig: HTTPAuthConfig?
    public var environment: Environment = .test
    
    public init() {}
    
    public var cardTokenizer: CardTokenizer {
        publicFacade
    }
    
    public var keyGenerator: KeyGenerator {
        publicFacade
    }
    

    private var publicFacade: PublicFacade {
        PublicFacade(networkLayer: networkLayer)
    }
    
    var networkLayer: CybersourceNetworkLayer {
        if let httpSignatureConfig = httpSingnatureConfig.map(createHTTPSignatureConfig)  {
            return createHTTPAuthLayer(config: httpSignatureConfig)
        }
        
        fatalError("Auth configs not set")
    }
    
    
    private func createHTTPAuthLayer(config: HTTPSignatureConfig) -> CybersourceNetworkLayer {
        return CybersourceNetworkLayerImp(factory: htppSignatureReqeustFactory(config: config))
    }
    
    
    private func htppSignatureReqeustFactory(config: HTTPSignatureConfig) -> HTTPSignatureDrcorator<CybersourceReqeustFactoryImp> {
        
        return HTTPSignatureDrcorator(signer: HTTPSignatureSigner(signatureConfig: config),
                                      decorated: defaultRequestFactory)
    }
    
    private var defaultRequestFactory: CybersourceReqeustFactoryImp {
        return CybersourceReqeustFactoryImp(flexRequestFactory: flexFactory,
                                            paymentFactory: paymentFactory)
    }
    
    private var flexFactory: FlexRequestFactory {
        return FlexRequestFactory(endpointProvider: endpointsConfig)
    }
    
    private var paymentFactory: PaymentRequestFactory {
        return PaymentRequestFactory(endpointProvider: endpointsConfig)
    }
    
    private func createHTTPSignatureConfig(from authConfig: HTTPAuthConfig) -> HTTPSignatureConfig {
        HTTPSignatureConfig(merchantID: authConfig.merchantID,
                            keyID: authConfig.keyID,
                            shardeKeyValue: authConfig.shardeKeyValue,
                            host: endpointsConfig.host)
    }
    
    private var endpointsConfig: EndpointsConfig {
        switch environment {
        case .prod: return .defaultProd
        case .test: return .defaultTest
        }
    }

}
