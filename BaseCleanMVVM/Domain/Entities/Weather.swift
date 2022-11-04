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
    let dt: Date
    let pressure: Int
    let humidity: Int
    let weather: [WeatherItem]
    let temp: Temperature
}

struct Temperature: Equatable {
    let day: Double
    let min: Double
    let max: Double
}

struct WeatherItem: Equatable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherPage: Equatable {
    let page: Int
    let totalPage: Int
    let weathers:[Weather]
}
