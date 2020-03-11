//
//  PublicFacade.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation
import AHNetwork

final class PublicFacade {
    let networkLayer: CybersourceNetworkLayer
    init(networkLayer: CybersourceNetworkLayer) {
        self.networkLayer = networkLayer
    }
}

extension PublicFacade: CardTokenizer {
    func tokenize(cardInfo: CardTokenizeInput, completion: @escaping AHCallback<TokenizedCard>) {
        networkLayer.sendRequest(of: .flex(.tokenizeCard(cardInfo)), completion: completion)
    }
}

extension PublicFacade: KeyGenerator {
    func generateKeys(using input: KeyGenerationInput,
                      completion: @escaping AHCallback<GeneratedKey>) {
        networkLayer.sendRequest(of: .flex(.generateKey(input)), completion: completion)
    }
}
