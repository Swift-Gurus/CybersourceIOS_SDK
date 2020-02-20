//
//  SHA256Converter.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation
import CommonCrypto

protocol SHA256Converter {
    func sha256(for data: Data) -> Data
    func sha256String(for data: Data) -> String
}


final class SHA256ConverterImp: SHA256Converter {
    func sha256(for data: Data) -> Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return Data(hash)
    }
    
    func sha256String(for data: Data) -> String {
        return sha256(for: data).base64EncodedString()
    }

}
