//
//  WeatherResponseDTO+Mapping.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//

import Foundation

// MARK: - Data Transfer Object

struct WeatherResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case weathers = "list"
    }
    let weathers: [WeatherDTO]
}

extension WeatherResponseDTO {
    struct WeatherDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id = "dt"
            case pressure
            case humidity
            case days = "weather"
            case temp
        }
        let id: TimeInterval
        let pressure: Int
        let humidity: Int
        let days: [WeatherItemDTO]
        let temp: TempDTO
    }
}

extension WeatherResponseDTO {
    struct WeatherItemDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case des = "description"
        }
        let des: String
    }
}
    
extension WeatherResponseDTO {
    struct TempDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case min
            case max
        }
        let min: Double
        let max: Double
    }
}

// MARK: - Mappings to Domain

extension WeatherResponseDTO {
    func toDomain() -> WeatherPage {
        return .init(page: 1,
                     totalPages: 1,
                     weathers: weathers.map { $0.toDomain() })
    }
}

extension WeatherResponseDTO.WeatherDTO {
    func toDomain() -> Weather {
        return .init(id: Weather.Identifier(id), pressure: pressure, humidity: humidity, weather: days.map {$0.toDomain()}, temp: temp.toDomain())
    }
}


extension WeatherResponseDTO.WeatherItemDTO {
    func toDomain() -> WeatherItem {
        return .init(description: des)
    }
}

extension WeatherResponseDTO.TempDTO {
    func toDomain() -> Temperature {
        return .init(min: min, max: max)
    }
}

