//
//  GeneratedKey.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation


public struct GeneratedKey: Decodable {
    let keyId: String
    let der: Der
    let jwk: JWK?
}

extension GeneratedKey {
    struct Der: Decodable {
        let format: String
        let algorithm: String
        let publicKey: String
    }
    
    
    struct JWK: Decodable {
        let kty: String
        let use: String
        let kid: String
        let n: String
        let e: String
    }
}
