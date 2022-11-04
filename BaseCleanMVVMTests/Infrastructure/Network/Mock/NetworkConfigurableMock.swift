//
//  NetworkConfigurableMock.swift
//  BaseCleanMVVMTests
//
//  Created by AnhNguyen on 03/11/2022.
//

import Foundation
@testable import BaseCleanMVVM

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    
    var headers: [String : String] = [:]
    
    var queryParameters: [String : String] = [:]
}
