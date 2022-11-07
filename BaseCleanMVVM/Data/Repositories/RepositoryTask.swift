//
//  RepositoryTask.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
