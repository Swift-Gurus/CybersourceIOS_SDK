//
//  GeneratedKey.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation


public struct GeneratedKey: Decodable {
    public let keyId: String
    public let der: Der
    public let jwk: JWK?
}

extension GeneratedKey {
    public struct Der: Decodable {
        public let format: String
        public let algorithm: String
        public let publicKey: String
    }
    
    
    public struct JWK: Decodable {
        public let kty: String
        public let use: String
        public let kid: String
        public let n: String
        public let e: String
    }
}
