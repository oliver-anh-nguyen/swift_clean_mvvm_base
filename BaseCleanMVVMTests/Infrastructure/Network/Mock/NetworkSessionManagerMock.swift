//
//  NetworkSessionManagerMock.swift
//  BaseCleanMVVMTests
//
//  Created by AnhNguyen on 03/11/2022.
//

import Foundation
@testable import BaseCleanMVVM

struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        completion(data, response, error)
        return URLSessionDataTask()
    }
}
