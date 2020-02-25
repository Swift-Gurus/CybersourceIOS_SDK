//
//  RequestSigner.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation
import AHNetwork

protocol RequestSigner {
    func sign(request: CybersourceRequest) -> CybersourceRequest
}

final class HTTPSignatureSigner: RequestSigner {
    
    let signatureConfig: HTTPSignatureConfig
    let defaultHeaders: [HeaderKey: String]
    let digestCreator: DigestCreator
    let dateProvider: CurrentDateProvider
    let hMACConverter: HMACConverter
    init(signatureConfig: HTTPSignatureConfig,
         dateProvider: CurrentDateProvider = CurrentDateProviderImp(),
         digestCreator: DigestCreator = DigestCreatorImp(),
         hMACConverter: HMACConverter = HMACConverterImp()) {
        
        defaultHeaders = [.merchantID: signatureConfig.merchantID,
                          .host: signatureConfig.host]
        
        self.signatureConfig = signatureConfig
        self.digestCreator = digestCreator
        self.dateProvider = dateProvider
        self.hMACConverter = hMACConverter
    }
    
    func sign(request: CybersourceRequest) -> CybersourceRequest {
        let headers = createHeaders(for: request)
        let additionalHeaders: [HeaderKey: String] = [.content_type: "application/json"]
        return request.appending(headers: headers)
                      .appending(headers: additionalHeaders.normalize)
    }
    
    private func createHeaders(for request: CybersourceRequest) -> [String: String] {
        let expDigest = digest(for: request)
        var mHeaders = defaultHeaders
        let hash: [HeaderKey: String] = [.host: signatureConfig.host,
                                         .date: dateProvider.currentDateString,
                                         .requestTarget: requestTargetString(from: request),
                                         .digest: digest(for: request),
                                         .merchantID: signatureConfig.merchantID]
        let config = configFor(type: request.method)
        let signature = createSignature(for: hash, using: config)
        mHeaders[.date] = dateProvider.currentDateString
        mHeaders[.signature] = signature
        if !expDigest.isEmpty {
            mHeaders[.digest] = expDigest
        }
        return mHeaders.normalize
    }
    
    private func digest(for request: CybersourceRequest) -> String {
        return request.body.map(digestCreator.createDigestString) ?? ""
    }


    private func createSignature(for hash: [HeaderKey: String],
                                 using config: SignatureConfig) -> String {
        let signatureBase = createSignatureBase(from: hash, order: config.headers)
        let signatureDigest = hMACConverter.calculateHash(for: signatureBase, using: config.sharedKey)
        return createSignatureString(from: config, signature: signatureDigest)
    }
    
    private func signatureHeader(headers: [HeaderKey]) -> String {
        return headers.map({ $0.formattedValue }).joined(separator: " ")
    }
    
    private func createSignatureBase(from hash: [HeaderKey: String], order: [HeaderKey]) -> String {
        return order.reduce(into: []) { (acc, key) in
            guard let value = hash[key] else { return }
            acc.append("\(key.formattedValue): \(value)")
        }.joined(separator: "\n")
    }
    
    private func requestTargetString(from request: CybersourceRequest) -> String {
        return "\(request.method.rawValue.lowercased()) \(request.path.lowercased())"
    }
    
    private func createSignatureString(from config: SignatureConfig, signature: String) -> String {
        let keyString = "keyid=\"\(config.keyID)\""
        let algorithmString = "algorithm=\(config.algorithm)"
        let headerString = "headers=\"\(signatureHeader(headers: config.headers))\""
        return "\(keyString), \(algorithmString), \(headerString), signature=\"\(signature)\""

    }
 

    private func configFor(type: AHMethod) ->  SignatureConfig {
        let headers: [HeaderKey] = type != .get ? [.host, .date, .requestTarget, .digest,. merchantID]
                                                : [.host, .date, .requestTarget, .merchantID]
       return SignatureConfig(keyID: signatureConfig.keyID,
                              algorithm: "\"HmacSHA256\"",
                              sharedKey: signatureConfig.shardeKeyValue,
                              headers: headers)
    }

}


extension HTTPSignatureSigner {
    enum HeaderKey: String {
        case merchantID = "v-c-merchant-id"
        case date = "Date"
        case host = "Host"
        case content_type = "Content-Type"
        case digest = "Digest"
        case signature = "Signature"
        case requestTarget = "(request-target)"
        
        var formattedValue: String {
            return rawValue.lowercased()
        }
    }
    
    
    
    struct SignatureConfig {
        let keyID: String
        let algorithm: String
        let sharedKey: String
        let headers: [HeaderKey]
        
        
        var encodedKey: Data {
            return Data(base64Encoded: sharedKey)!
        }
    }
}
