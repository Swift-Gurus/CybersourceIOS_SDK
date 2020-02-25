//
//  Encryptor.swift
//  AHNetwork
//
//  Created by Alex Hmelevski on 2020-02-15.
//

import Foundation
import Security

protocol Encryptor {
    var publicKey: String { get set }
    func encryptMessage(_ message: String) throws -> String
}


final class RSAEncryptor: Encryptor {
    var publicKey: String = ""
    private let tagName = "mCrewPublicKey"
    private let keyManager = RSAUtilsWrapper()
    func encryptMessage(_ message: String) throws -> String {         
        do {
            defer { removeKey() }
            
            let publicSecKey = try getSecKey()
            let plainData = try message.data(using: .utf8)
            let data = try SecKeyCreateEncryptedData(publicSecKey, .rsaEncryptionOAEPSHA256, plainData)
            return data.base64EncodedString()
        } catch {
            throw error
        }
        
    }
    
    
    
    private func getSecKey() throws -> SecKey {
        do {
            let key = try keyManager.addRSAPublicKey(publicKey, tagName: tagName)
            guard let publicSecKey =  key else {
                throw GeneralError(errorDescription: "Could not find the key for \(tagName)")
            }
            return publicSecKey
        } catch {
            throw error
        }
    }
    
    private func removeKey() {
        keyManager.deleteRSAKeyFromKeychain(tagName)
    }

}
