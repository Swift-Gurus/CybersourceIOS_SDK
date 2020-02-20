//
//  DigestCreator.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation

protocol DigestCreator {
    func createDigestString(for data: Data) -> String
}

final class DigestCreatorImp: DigestCreator {
    let constPrefix = "SHA-256"
    let sha256Converter: SHA256Converter
    let separator = "="
    init(sha256Converter: SHA256Converter = SHA256ConverterImp()) {
        self.sha256Converter = sha256Converter
    }
    
    func createDigestString(for data: Data) -> String {
        
        let shaString = sha256Converter.sha256String(for: data)
        return [constPrefix, shaString].joined(separator: separator)
    }
}
