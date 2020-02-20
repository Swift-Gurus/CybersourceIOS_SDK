//
//  PaymentRequestFactory.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-17.
//

import Foundation
import AHNetwork

enum PaymentRequestType {
    case payment(PaymentInput)
}

protocol PaymentPathStringProvider {
    var paymentPath: String { get }
}

final class PaymentRequestFactory: NetworkRequestFactory {
    
    let endpointProvider: HostStringProvider & PaymentPathStringProvider
    let basicRequest: CybersourceRequest
    let dataSerializer = JSONEncoder()
    var basicPostRequest: CybersourceRequest {
      return basicRequest.new(method: .post)
    }
    var paymentPath: String {
        endpointProvider.paymentPath
    }
    init(endpointProvider: HostStringProvider & PaymentPathStringProvider) {
        self.endpointProvider = endpointProvider
        
        basicRequest = CybersourceRequest(baseURL: endpointProvider.host,
                                                 headers: [:])
    }
    func getRequest(of type: PaymentRequestType) -> IRequest {
        switch type {
        case let .payment(input): return createPaymentRequest(using: input)
        }
    }
    
    private func createPaymentRequest(using info: PaymentInput) -> CybersourceRequest {
        let request = basicPostRequest.appended(path: paymentPath)
        return addedBody(to: request, bodyObject: info)
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
