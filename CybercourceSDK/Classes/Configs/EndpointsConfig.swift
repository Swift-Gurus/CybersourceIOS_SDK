//
//  EndpointsConfig.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation

struct EndpointsConfig {
    let host: String
    let flexPath: String
    let paymentPath: String
}

extension EndpointsConfig: FlexPathStringProvider {}
extension EndpointsConfig: HostStringProvider {}
extension EndpointsConfig: PaymentPathStringProvider {}

extension EndpointsConfig {
    static var defaultProd: EndpointsConfig {
        EndpointsConfig(host: "api.cybersource.com",
                        flexPath: "/flex/v1",
                        paymentPath: "/pts/v2/payments")
    }
    
    static var defaultTest: EndpointsConfig {
        EndpointsConfig(host: "apitest.cybersource.com",
                        flexPath: "/flex/v1",
                        paymentPath: "/pts/v2/payments")
    }
}
