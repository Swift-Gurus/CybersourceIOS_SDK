//
//  CurrentDateProvider.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-17.
//

import Foundation


protocol CurrentDateProvider {
    var currentDateString: String { get }
}


final class CurrentDateProviderImp: CurrentDateProvider {
    
    lazy var dateFormatter = DateFormatter()
    var currentDateString: String {
        return dateFormatter.string(from: Date())
    }
    
    init() {
        dateFormatter.dateFormat = "EEE',' dd MMM yyyy HH':'mm':'ss z"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    }
}
