//
//  WeatherRequestDTO+Mapping.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//

import Foundation

struct WeatherRequestDTO: Encodable {
    let q: String
    let cnt: Int
    let unit: String
}
