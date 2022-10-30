//
//  AppConfigurations.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 29/10/2022.
//

import Foundation

final class AppConfigurations {
    
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
}
