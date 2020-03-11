//
//  CardTokenizer.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation
import AHNetwork

public protocol CardTokenizer {
    func tokenize(cardInfo: CardTokenizeInput, completion: @escaping AHCallback<TokenizedCard>)
}

public protocol PublicKeyCRUD {
    var publicKey: String { get set }
}

final class CardTokenizerEncryptionDecorator: CardTokenizer {
    let tokenizer: CardTokenizer
    var encryptor: Encryptor
    let publicKeyReader: PublicKeyCRUD
    init(tokenizer: CardTokenizer,
         publicKeyReader: PublicKeyCRUD,
         encryptor: Encryptor = RSAEncryptor()) {
        self.tokenizer = tokenizer
        self.encryptor = encryptor
        self.publicKeyReader = publicKeyReader
    }
    
    func tokenize(cardInfo: CardTokenizeInput, completion: @escaping AHCallback<TokenizedCard>) {
        do {
            encryptor.publicKey = publicKeyReader.publicKey
            let encryptedPAN = try encryptor.encryptMessage(cardInfo.cardInfo.cardNumber)
            let encryptedInfo = cardInfo.updatedCardInfo(with: encryptedPAN)
            tokenizer.tokenize(cardInfo: encryptedInfo, completion: completion)
            
        } catch {
            completion(.wrong(error))
        }
    }
    
}
