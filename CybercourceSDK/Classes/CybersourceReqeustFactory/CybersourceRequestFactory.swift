//
//  CybersourceReqeustFactory.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation
import AHNetwork

protocol CybersourceReqeustFactory: NetworkRequestFactory {
    func getRequest(of type: CybersourceReqeustType) -> IRequest
}


class CybersourceReqeustFactoryImp: CybersourceReqeustFactory {
    
    private let flexRequestFactory: FlexRequestFactory
    private let paymentFactory: PaymentRequestFactory
    
    init(flexRequestFactory: FlexRequestFactory,
         paymentFactory: PaymentRequestFactory) {
        self.flexRequestFactory = flexRequestFactory
        self.paymentFactory = paymentFactory

    }
    func getRequest(of type: CybersourceReqeustType) -> IRequest {
        switch type {
        case let .flex(flexType): return flexRequestFactory.getRequest(of: flexType)
        case let .payment(type): return paymentFactory.getRequest(of: type)
        }
    }
    
}
