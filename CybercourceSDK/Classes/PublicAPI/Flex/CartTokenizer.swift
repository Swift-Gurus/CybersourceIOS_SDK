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
