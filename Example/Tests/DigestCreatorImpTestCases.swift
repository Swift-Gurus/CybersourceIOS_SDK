//
//  DigestCreatorImpTestCases.swift
//  CybercourceSDK_Tests
//
//  Created by Alex Hmelevski on 2020-02-16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import CybercourceSDK


class DigestCreatorImpTestCases: XCTestCase {

    var creatorToTest = DigestCreatorImp()
    let encoder = JSONEncoder()
    
    func test_adds_prefix() {
        let data = try! encoder.encode(KeyGenerationInput())
        debugPrint(String(data: data, encoding: .utf8))
        let string = creatorToTest.createDigestString(for: data)
        XCTAssertEqual(string, "SHA-256=bena9bhB3Jy4uPvfu1tAC0uN8AuzzM+xjqmDwR5//EA=")
    }
}
