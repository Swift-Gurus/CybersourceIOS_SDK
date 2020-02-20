//
//  Encryptor.swift
//  AHNetwork
//
//  Created by Alex Hmelevski on 2020-02-15.
//

import Foundation
import Security
import EitherResult


protocol Encryptor {
    var publicKey: String { get set }
    func encryptMessage(_ message: String) -> ALResult<String>
}


final class RSAEncryptor: Encryptor {
    var publicKey: String = ""
    
    func encryptMessage(_ message: String) -> ALResult<String> {
        fatalError()
    }
    
    
}
