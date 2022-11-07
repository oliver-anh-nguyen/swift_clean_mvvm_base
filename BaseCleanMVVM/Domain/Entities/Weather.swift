//
//  Weather.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 30/10/2022.
//

import Foundation

struct Weather: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let dt: TimeInterval
    let pressure: Int
    let humidity: Int
    let weather: [WeatherItem]
    let temp: Temperature
}

struct Temperature: Equatable {
    let min: Double
    let max: Double
}

struct WeatherItem: Equatable {
    let description: String
}

struct WeatherPage: Equatable {
    let page: Int
    let totalPages: Int
    let weathers:[Weather]
}
