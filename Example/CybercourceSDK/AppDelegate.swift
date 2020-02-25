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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tokenizer: KeyGenerator!
    var encryptor: CardTokenizer!

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
        encryptor = builder.cardTokenizer

 
        let keyInput = KeyGenerationInput(encryptionType: .rsaOaep256, targetOrigin: "https://example.com")
        tokenizer.generateKeys(using: keyInput) {[weak self] (result) in
            guard let `self` = self else { return }
            result.do(work: self.tokenizeCard)
                  .onError({ debugPrint($0) })
            
        }
      return true
  
    }
    
    
    
    
    private func tokenizeCard(using publicKey: GeneratedKey) {
        let cardNumber = "4111111111111111"
        let key = try! CryptorRSA.createPublicKey(withPEM: publicKey.der.publicKey)
        let message = try! CryptorRSA.createPlaintext(with: cardNumber, using: .utf8)
        let ecnrypted = try! message.encrypted(with: key, algorithm: .sha256)
        let input = CardTokenizeInput(cardNumber: ecnrypted!.base64String,
                                      cardExpirationMonth: "05",
                                      cardExpirationYear: "25",
                                      cardType: "001")
        
        encryptor.tokenize(cardInfo: input) { (result) in
            
            result.do(work: { debugPrint($0)} )
                .onError({ debugPrint($0.localizedDescription)})
        }
    }
    
    
    private func printError(response: AHNetworkResponse) {
        
    }
    
//    func print(k: Array<UInt8>) {
//        debugPrint(k)
//    }
    
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

