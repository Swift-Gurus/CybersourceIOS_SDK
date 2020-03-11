//
//  Extensions.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation

struct GeneralError: LocalizedError {
    let errorDescription: String
    
}

extension Dictionary where Key: RawRepresentable, Key.RawValue  == String {
    var normalize: [String: Value] {
       return reduce(into: [:]) { (q, pair) in
            q[pair.key.rawValue] = pair.value
        }
    }
}





extension String {
    func data(using encoding: String.Encoding,
              allowLossyConversion: Bool = false) throws -> Data {
        guard let data = data(using: encoding,
                              allowLossyConversion: allowLossyConversion) else {
            throw GeneralError(errorDescription: "Could not convert \(self) to data")
        }
        return data
    }
}


public func SecKeyCreateEncryptedData(_ key: SecKey,
                                      _ algorithm: SecKeyAlgorithm,
                                      _ plaintext: Data) throws -> Data {
    let error: UnsafeMutablePointer<Unmanaged<CFError>?>? = nil
    guard let data = SecKeyCreateEncryptedData(key, algorithm, plaintext as CFData,error) as Data? else {
        let newErrorString = error?.debugDescription ?? "Could not Encrypt data"
        throw GeneralError(errorDescription: newErrorString)
    }
    return data
}
