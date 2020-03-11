//
//  SHA256ConverterMock.swift
//  CybercourceSDK_Tests
//
//  Created by Alex Hmelevski on 2020-02-16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
@testable import CybercourceSDK

final class SHA256ConverterMock: SHA256Converter {
    
    var testString = "TEST"
    func sha256(for data: Data) -> Data {
        return Data(base64Encoded: testString)!
    }
    
    func sha256String(for data: Data) -> String {
        return testString
    }
    
    
}
