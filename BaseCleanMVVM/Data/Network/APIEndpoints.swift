//
//  APIEndpoints.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//

struct APIEndpoints {
    
    static func getWeather(with weatherRequestDTO: WeatherRequestDTO) -> Endpoint<WeatherResponseDTO> {
        return Endpoint(path: "data/2.5/forecast/daily",
                        method: .get,
                        queryParametersEncodable: weatherRequestDTO)
    }
    
}

