//
//  TokenizedCard.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation



public struct TokenizedCard: Codable {
    public let keyId: String?
    public let token: String?
    public let maskedPan: String?
    public let cardType: String?
    public let timestamp: Double?
    public let signedFields: String?
    public let signature: String?
    public let _embedded: EmbededCard?
}



public struct EmbededCard: Codable {
    public let icsReply: ICSReply

}



public struct ICSReply: Codable {
    public let requestId: String?
    public let _links: Links
}

public struct Links: Codable {
    public let `self`: SelfObject
}

public struct SelfObject: Codable {
    public let href: String
}


