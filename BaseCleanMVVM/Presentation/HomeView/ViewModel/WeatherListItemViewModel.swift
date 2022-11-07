//
//  WeatherListItemViewModel.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 03/11/2022.
//

import Foundation

struct WeatherListItemViewModel: Equatable {
    let date: String
    let averageTemp: String
    let pressure: String
    let humidity: String
    let desc: String
}

enum ConstantString {
    static let formatDateLbl = "Date: %@"
    static let formatAvgTempLbl = "Average Temperature: %dºC"
    static let formatPressureLbl = "Pressure: %d"
    static let formatHumidityLbl = "Humidity: %d%%"
    static let formatDescriptionLbl = "Description: %@"
}

extension WeatherListItemViewModel {
    init(weather: Weather) {
        let average = ((weather.temp.max + weather.temp.min) / 2.0).rounded(.toNearestOrEven)
        let timeStr = DateFormatterHelper.stringForDateInterval(
            timeIntervalSince1970: weather.dt,
            format: "EEE, dd MMM yyyy",
            timeIntervalType: .seconds
        )
        self.date = String(format: ConstantString.formatDateLbl, timeStr)
        self.averageTemp = String(format: ConstantString.formatAvgTempLbl, average)
        self.pressure = String(format: ConstantString.formatPressureLbl, weather.pressure)
        self.humidity = String(format: ConstantString.formatHumidityLbl, weather.humidity)
        self.desc = weather.weather.compactMap({ $0.description }).joined(separator: ", ")
    }
}


public enum TimeIntervalType {
    case seconds
    case milisecond
}

public enum DateFormatterHelper {
    public static func stringForDateInterval(
        timeIntervalSince1970: TimeInterval,
        format: String,
        timeIntervalType: TimeIntervalType = .milisecond
    ) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format

        let time: TimeInterval
        switch timeIntervalType {
        case .milisecond:
            time = timeIntervalSince1970 / 1_000
        case .seconds:
            time = timeIntervalSince1970
        }

        return dateFormater.string(from: Date(timeIntervalSince1970: time))
    }
}
