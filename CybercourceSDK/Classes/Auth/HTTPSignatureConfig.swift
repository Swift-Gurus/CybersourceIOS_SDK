//
//  HTTPSignatureConfig.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation

public struct HTTPAuthConfig {
    let merchantID: String
    let keyID: String
    let shardeKeyValue: String
    public init(merchantID: String,
                keyID: String,
                shardeKeyValue: String) {
        self.merchantID = merchantID
        self.keyID = keyID
        self.shardeKeyValue = shardeKeyValue
        
    }
}

struct HTTPSignatureConfig {
    let merchantID: String
    let keyID: String
    let shardeKeyValue: String
    let host: String
    
}
