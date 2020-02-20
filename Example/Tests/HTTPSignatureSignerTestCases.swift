//
//  HTTPSignatureSignerTestCases.swift
//  CybercourceSDK_Tests
//
//  Created by Alex Hmelevski on 2020-02-17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import CybercourceSDK

class HTTPSignatureSignerTestCases: XCTestCase {
    
    
    
    var signerToTest: HTTPSignatureSigner!
    let config = HTTPSignatureConfig(merchantID: "testmid",
                                     keyID: "01234567-0123-0123-0123-012345678912",
                                     shardeKeyValue: "0123k20MBbIB2t012345678993gHCIZsQKFpf7dR0hY=",
                                     host: "apitest.cybersource.com")
    let enpointsConfig = EndpointsConfig(host: "apitest.cybersource.com",
                                         flexPath: "/flex/v1",
                                         paymentPath: "/pts/v2/payments")
    var paymentRequestFactory: PaymentRequestFactory!
    var dateProviderMock = CurrentDateProviderMock()
    override func setUp() {
        paymentRequestFactory = PaymentRequestFactory(endpointProvider: enpointsConfig)
        signerToTest = HTTPSignatureSigner(signatureConfig: config,
                                           dateProvider: dateProviderMock)
    }

    
    func test_headers_contain_merchant() {
        XCTAssertEqual(signedRequest.headers["v-c-merchant-id"], "testmid")
    }
    
    func test_headers_contain_date() {
        XCTAssertEqual(signedRequest.headers["Date"], dateProviderMock.currentDateString)
    }
    
    func test_headers_contain_host() {
        XCTAssertEqual(signedRequest.headers["Host"], config.host)
    }
    
    func test_body_hash_contains_proper_value() {
        XCTAssertEqual(signedRequest.headers["Digest"],
                       "SHA-256=CihgCiDHWGJOylj8d8HGrxZY4oaTHzZPIf1PNI3OCXQ=")
        
    }

    
    private var signedRequest: CybersourceRequest {
        let request = paymentRequestFactory.getRequest(of: .payment(.defaultMock))
        let cRequest = CybersourceRequest(from: request)
        return signerToTest.sign(request: cRequest)
    }

}
