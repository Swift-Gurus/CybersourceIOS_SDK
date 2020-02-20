//
//  DictionaryExtension.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation

extension Dictionary where Key: RawRepresentable, Key.RawValue  == String {
    var normalize: [String: Value] {
       return reduce(into: [:]) { (q, pair) in
            q[pair.key.rawValue] = pair.value
        }
    }
}



extension Data {
   struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
