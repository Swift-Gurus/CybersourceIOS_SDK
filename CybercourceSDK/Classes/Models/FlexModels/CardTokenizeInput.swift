//
//  CardInfo.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation

public struct CardTokenizeInput: Encodable {
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
    
}
