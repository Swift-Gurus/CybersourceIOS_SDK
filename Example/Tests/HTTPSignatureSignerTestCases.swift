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
    let config = HTTPSignatureConfig(merchantID: "testrest",
                                     keyID: "08c94330-f618-42a3-b09d-e1e43be5efda",
                                     shardeKeyValue: "yBJxy6LjM2TmcPGu+GaJrHtkke25fPpUX+UY6/L/1tE=",
                                     host: "apitest.cybersource.com")
    let enpointsConfig = EndpointsConfig(host: "apitest.cybersource.com",
                                         flexPath: "/flex/v1",
                                         paymentPath: "/pts/v2/payments")
    var paymentRequestFactory: PaymentRequestFactory!
    var flexFactory: FlexRequestFactory!
    var dateProviderMock = CurrentDateProviderMock()
    override func setUp() {
        paymentRequestFactory = PaymentRequestFactory(endpointProvider: enpointsConfig)
        flexFactory = FlexRequestFactory(endpointProvider: enpointsConfig)
        signerToTest = HTTPSignatureSigner(signatureConfig: config,
                                           dateProvider: dateProviderMock)
    }

    
    func test_headers_contain_merchant() {
        XCTAssertEqual(signedRequest.headers["v-c-merchant-id"], config.merchantID)
    }
    
    func test_headers_contain_date() {
        XCTAssertEqual(signedRequest.headers["Date"], dateProviderMock.currentDateString)
    }
    
    func test_headers_contain_host() {
        XCTAssertEqual(signedRequest.headers["Host"], config.host)
    }
    
    func test_body_hash_contains_proper_value() {
        XCTAssertEqual(signedRequest.headers["Digest"],
                       "SHA-256=bena9bhB3Jy4uPvfu1tAC0uN8AuzzM+xjqmDwR5//EA=")
        
    }
    
    func test_signature_value() {
        let extSignature = "keyid=\"08c94330-f618-42a3-b09d-e1e43be5efda\", algorithm=\"HmacSHA256\", headers=\"host date (request-target) digest v-c-merchant-id\", signature=\"r15B0rQB/gPdOWOURCB2bqotq+td5oA7EEFmuS8KTnQ=\""
        XCTAssertEqual(extSignature, signedRequest.headers["Signature"])
    }

    
    private var signedRequest: CybersourceRequest {
        let request = flexFactory.getRequest(of: .generateKey(KeyGenerationInput()))
        let cRequest = CybersourceRequest(from: request)
        return signerToTest.sign(request: cRequest)
    }

}
