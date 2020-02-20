//
//  AppDelegate.swift
//  CybercourceSDK
//
//  Created by c693a6faca023f9cc99909b1e119c25011f8a8b8 on 02/12/2020.
//  Copyright (c) 2020 c693a6faca023f9cc99909b1e119c25011f8a8b8. All rights reserved.
//

import UIKit
import CryptoSwift
import CryptorRSA
import CybercourceSDK
import AHNetwork
import CommonCrypto


func decodeBase64(input: String)->String{
        let base64Decoded = NSData(base64Encoded: input, options:   NSData.Base64DecodingOptions(rawValue: 0))
            .map({ NSString(data: $0 as Data, encoding: String.Encoding.utf8.rawValue) })

        return base64Decoded!! as String
}

extension Data {
    
    var hex: String {
        var string = ""
        enumerateBytes { pointer, index, _ in
            for i in index..<pointer.count {
                string += String(format: "%02x", pointer[i])
            }
        }
        return string
    }
}

public struct HMAC {

    // MARK: - Types
    public enum Algorithm {
        case sha1
        case md5
        case sha256
        case sha384
        case sha512
        case sha224

        public var algorithm: CCHmacAlgorithm {
            switch self {
            case .md5: return CCHmacAlgorithm(kCCHmacAlgMD5)
            case .sha1: return CCHmacAlgorithm(kCCHmacAlgSHA1)
            case .sha224: return CCHmacAlgorithm(kCCHmacAlgSHA224)
            case .sha256: return CCHmacAlgorithm(kCCHmacAlgSHA256)
            case .sha384: return CCHmacAlgorithm(kCCHmacAlgSHA384)
            case .sha512: return CCHmacAlgorithm(kCCHmacAlgSHA512)
            }
        }

        public var digestLength: Int {
            switch self {
            case .md5: return Int(CC_MD5_DIGEST_LENGTH)
            case .sha1: return Int(CC_SHA1_DIGEST_LENGTH)
            case .sha224: return Int(CC_SHA224_DIGEST_LENGTH)
            case .sha256: return Int(CC_SHA256_DIGEST_LENGTH)
            case .sha384: return Int(CC_SHA384_DIGEST_LENGTH)
            case .sha512: return Int(CC_SHA512_DIGEST_LENGTH)
            }
        }
    }


    // MARK: - Signing
    public static func sign(data: Data, algorithm: Algorithm, key: Data) -> Data {
        let signature = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: algorithm.digestLength)

        data.withUnsafeBytes { dataBytes in
            key.withUnsafeBytes { keyBytes in
                CCHmac(algorithm.algorithm, keyBytes, key.count, dataBytes, data.count, signature)
            }
        }

        return Data(bytes: signature, count: algorithm.digestLength)
    }

    public static func sign(message: String, algorithm: Algorithm, key: String) -> String? {
        guard let messageData = message.data(using: .utf8),
            let keyData = Data(base64Encoded: key)
        else { fatalError() }
        debugPrint(keyData as? NSData)
        return sign(data: messageData, algorithm: algorithm, key: keyData).hex
    }
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tokenizer: KeyGenerator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let httpAuthConfig = HTTPAuthConfig(merchantID: "aldogroup",
//                                            keyID: "9d3badef-b0a2-4dec-87ec-a9ad4cc1863e",
//                                            shardeKeyValue: "sC/DHhM506BRWgkpzyBCpQ1/NtSeNwb1ZGWq/S8JpQQ=")
        
        
          let httpAuthConfig = HTTPAuthConfig(merchantID: "testrest",
                                                    keyID: "08c94330-f618-42a3-b09d-e1e43be5efda",
                                                    shardeKeyValue: "yBJxy6LjM2TmcPGu+GaJrHtkke25fPpUX+UY6/L/1tE=")
        let builder = CybercourceBuilder()
        builder.httpSingnatureConfig = httpAuthConfig
        tokenizer = builder.keyGenerator
        let keyInput = KeyGenerationInput()
        tokenizer.generateKeys(using: keyInput) { (result) in
//            debugPrint(result.onError(self.printError))
        }
        
  
        let string = "host: apitest.cybersource.com\ndate: Wed, 19 Feb 2020 19:26:13 GMT\n(request-target): post /flex/v1/keys\ndigest: SHA-256=bena9bhB3Jy4uPvfu1tAC0uN8AuzzM+xjqmDwR5//EA=\nv-c-merchant-id: testrest"

        let keyDataString = "yBJxy6LjM2TmcPGu+GaJrHtkke25fPpUX+UY6/L/1tE="
//        let keyDataString = "7e4cad975152802dcb2bb2ad2b2ce9ba52200b17a5c6a7eea6dc40fd2254cf07"
     
        
        let base64Encoded = keyDataString
        let decodedData = Data(base64Encoded: base64Encoded)!
        
        let decodedString = String(data: decodedData, encoding: .nonLossyASCII)!
        print(decodedData as? NSData)
        print(decodedString)
        return true
    }
    

    
//
//    func printError(_ error: Error) {
//        guard case let .responseError(response) = error as? CoreNetworkError else { return }
//        debugPrint(String(data: response.data, encoding: .utf8)!)
//
//
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

