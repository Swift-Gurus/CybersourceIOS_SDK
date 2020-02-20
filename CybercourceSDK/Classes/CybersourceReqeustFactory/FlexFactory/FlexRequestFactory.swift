//
//  FlexRequestFactory.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation
import AHNetwork

enum FlexRequestType {
    case generateKey(KeyGenerationInput)
    case tokenizeCard(CardTokenizeInput)
}

protocol HostStringProvider {
    var host: String { get }
}

protocol FlexPathStringProvider {
    var flexPath: String { get }
}

struct FlexRequestFactoryConfig {
    let hostProvider: HostStringProvider
}

final class FlexRequestFactory: NetworkRequestFactory  {
   
    typealias RequestType = FlexRequestType
    
    let basicRequest: CybersourceRequest
    let dataSerializer = JSONEncoder()
    let flexPath: String
    var basicPostRequest: CybersourceRequest {
        return basicRequest.new(method: .post)
    }
    init(endpointProvider: HostStringProvider & FlexPathStringProvider) {
        self.flexPath = endpointProvider.flexPath
        basicRequest = CybersourceRequest(baseURL: endpointProvider.host,
                                          headers: [:])
    }
    
    func getRequest(of type: FlexRequestType) -> IRequest {
        switch type {
        case let .generateKey(input): return createKeyGenerationRequest(input: input)
        case let .tokenizeCard(info): return createTokenizedRequest(using: info)
        }
    }

    private func createTokenizedRequest(using info: CardTokenizeInput) -> CybersourceRequest {
        let request = basicPostRequest.appended(path: flexPath.appending("/tokens"))
        return addedBody(to: request, bodyObject: info)
    }
    
    
    private func createKeyGenerationRequest(input: KeyGenerationInput) -> CybersourceRequest {
        let request = basicPostRequest.appended(path: flexPath.appending("/keys"))
        return addedBody(to: request, bodyObject: input)
    }
    
    
    private func addedBody<T: Encodable>(to request: CybersourceRequest,
                                         bodyObject: T) -> CybersourceRequest {
        do {
            return request.new(body: try dataSerializer.encode(bodyObject))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}



