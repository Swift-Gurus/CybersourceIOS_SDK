//
//  KeyGenerationInput.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation

public enum EncryptionType: String, Encodable {
    case none = "None"
    case rsaOaep256 = "RsaOaep256"
}


public struct KeyGenerationInput: Encodable {
    public let encryptionType: EncryptionType
    public let targetOrigin: String?
    
    public init(encryptionType: EncryptionType = .none,
                targetOrigin: String? = nil) {
        self.encryptionType = encryptionType
        self.targetOrigin = targetOrigin
    }
}
