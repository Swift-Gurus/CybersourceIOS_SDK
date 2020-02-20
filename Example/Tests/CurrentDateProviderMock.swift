//
//  CurrentDateProviderMock.swift
//  CybercourceSDK_Tests
//
//  Created by Alex Hmelevski on 2020-02-17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
@testable import CybercourceSDK

final class  CurrentDateProviderMock: CurrentDateProvider {
    var currentDateString: String {
        "Wed, 19 Feb 2020 19:26:13 GMT"
    }
}
