//
//  SignatureHeadersCreator.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation
import AHNetwork

final class HTTPSignatureDrcorator<Factory: CybersourceReqeustFactory>: CybersourceReqeustFactory {

    let signer: RequestSigner
    let decorated: Factory
    
    init(signer: RequestSigner, decorated: Factory) {
        self.decorated = decorated
        self.signer = signer
    }
 
    func getRequest(of type: CybersourceReqeustType) -> IRequest {
        let request = decorated.getRequest(of: type)
        let signedRequest = signer.sign(request: CybersourceRequest(from: request))
        return signedRequest
    }
}
