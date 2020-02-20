//
//  PaymentInput.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-17.
//

import Foundation

struct PaymentInput: Encodable {
    let clientReferenceInformation: ClientReferenceInformation
    let processingInformation: ProcessingInformation
    let paymentInformation: PaymentInformation
    let orderInformation: OrderInformation
}


struct ClientReferenceInformation: Encodable {
    let code: String
}

struct ProcessingInformation: Encodable  {
    let commerceIndicator: String
}

struct PaymentInformation: Encodable {
    let card: CardInfo
}

struct AmountDetails: Encodable {
    let totalAmount: String
    let currency: String
}

struct OrderInformation: Encodable {
    let amountDetails: AmountDetails
    let billTo: Bill
}

struct Bill: Encodable {
    let firstName: String
    let lastName: String
    let company: String
    let address1: String
    let address2: String
    let locality: String
    let administrativeArea: String
    let postalCode: String
    let country: String
    let email: String
    let phoneNumber: String
}


struct SubMerchant: Encodable {
    let cardAcceptorId: String
    let country: String
}


