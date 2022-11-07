//
//  Mock+Stub.swift
//  BaseCleanMVVMTests
//
//  Created by AnhNguyen on 06/11/2022.
//

import Foundation
@testable import BaseCleanMVVM

extension Weather {
    static func stub(id: Weather.Identifier = "id1",
                     dt: TimeInterval = 1667732400,
                     pressure: Int = 1001,
                     humidity: Int = 92,
                     weathers:[WeatherItem],
                     temp: Temperature) -> Self {
        Weather(id: id, dt: dt, pressure: pressure, humidity: humidity, weather: weathers, temp: temp)
    }
}

extension WeatherItem {
    static func stub(des: String = "description") -> Self {
        WeatherItem(description: des)
    }
}

extension Temperature {
    static func stub(min: Double = 100.24,
                     max: Double = 50.39) -> Self {
        Temperature(min: min, max: max)
    }
}
