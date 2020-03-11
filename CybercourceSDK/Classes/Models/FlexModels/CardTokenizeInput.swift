//
//  CardInfo.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation

public struct CardInfoInput: Encodable {
    let cardNumber: String
    let cardExpirationMonth: String?
    let cardExpirationYear: String?
    let cardType: String
    
    public init(cardNumber: String,
                cardExpirationMonth: String? = nil,
                cardExpirationYear: String? = nil,
                cardType: String) {
         self.cardType = cardType
         self.cardNumber = cardNumber
         self.cardExpirationYear = cardExpirationYear
         self.cardExpirationMonth = cardExpirationMonth
    }
    
    
    func updatedCardInfo(with newCardNumber: String) -> CardInfoInput {
        return CardInfoInput(cardNumber: newCardNumber,
                             cardExpirationMonth: cardExpirationMonth,
                             cardExpirationYear: cardExpirationYear,
                             cardType: cardType)
    }
}

public struct CardTokenizeInput: Encodable {
    let keyId: String
    let cardInfo: CardInfoInput
  
    public init(keyId: String,
                cardInfo: CardInfoInput) {
        self.keyId = keyId
        self.cardInfo = cardInfo
    }
  
    
    func updatedCardInfo(with newCardNumber: String) -> CardTokenizeInput {
        return CardTokenizeInput(keyId: keyId,
                                 cardInfo: cardInfo.updatedCardInfo(with: newCardNumber))
    }
}
