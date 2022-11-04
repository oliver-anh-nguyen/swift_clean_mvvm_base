//
//  UseCase.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 03/11/2022.
//

import Foundation

public protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
