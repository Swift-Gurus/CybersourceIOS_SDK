//
//  HMACConverter.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-20.
//

import Foundation
import CryptoSwift

protocol HMACConverter {
    func calculateHash(for string: String, using key: String) -> String
}

final class HMACConverterImp: HMACConverter {
    func calculateHash(for string: String, using key: String) -> String {
        guard let keyData = Data(base64Encoded: key) else {
                return string
        }

        let hmac = HMAC(key: keyData.bytes, variant: .sha256)
        let signatureDigest = try? hmac.authenticate(string.bytes)
        return signatureDigest?.toBase64() ?? ""
    }
}
