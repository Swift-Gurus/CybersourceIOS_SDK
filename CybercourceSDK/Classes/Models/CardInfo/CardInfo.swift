//
//  CardInfo.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-17.
//

import Foundation

public struct CardInfo: Encodable {
    let number: String
    let expirationMonth: String
    let expirationYear: String
    let securityCode: String

    public init(number: String,
                expirationMonth: String,
                expirationYear: String,
                securityCode: String) {
        self.number = number
        self.expirationMonth = expirationMonth
        self.expirationYear = expirationYear
        self.securityCode = securityCode
    }
    
}
