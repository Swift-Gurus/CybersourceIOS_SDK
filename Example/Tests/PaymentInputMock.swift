//
//  PaymentInputMock.swift
//  CybercourceSDK_Tests
//
//  Created by Alex Hmelevski on 2020-02-17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
@testable import CybercourceSDK
extension PaymentInput {
    static var defaultMock: PaymentInput {
        PaymentInput(clientReferenceInformation: .defaultMock,
                     processingInformation: .defaultMock,
                     paymentInformation: .defaultMock,
                     orderInformation: .defaultMock)
    }
}


extension ClientReferenceInformation {
    static var defaultMock: ClientReferenceInformation {
        ClientReferenceInformation(code: "TC50171_3")
    }
}

extension ProcessingInformation {
    static var defaultMock: ProcessingInformation {
        ProcessingInformation(commerceIndicator: "internet")
    }
}

extension PaymentInformation {
    static var defaultMock: PaymentInformation {
        PaymentInformation(card: .defaultMock)
    }
}

extension CardInfo {
    static var defaultMock: CardInfo {
        CardInfo(number: "4111111111111111",
                 expirationMonth: "12",
                 expirationYear: "2031",
                 securityCode: "123")
    }
}


extension OrderInformation {
    static var defaultMock: OrderInformation {
        OrderInformation(amountDetails: .defaultMock,
                         billTo: .defaultMock)
    }
}

extension AmountDetails {
    static var defaultMock: AmountDetails {
        AmountDetails(totalAmount: "102.21",
                      currency: "USD")
    }
}

extension Bill {
    static var defaultMock: Bill {
        Bill(firstName: "John",
             lastName: "Doe",
             company: "Visa",
             address1: "1 Market St",
             address2: "Address 2",
             locality: "san francisco",
             administrativeArea: "CA",
             postalCode: "94105",
             country: "US",
             email: "test@cybs.com",
             phoneNumber: "4158880000")
    }
}

