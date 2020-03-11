//
//  KeyGenerator.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation
import AHNetwork

public protocol KeyGenerator {
    func generateKeys(using input: KeyGenerationInput,
                      completion: @escaping AHCallback<GeneratedKey>)
}
