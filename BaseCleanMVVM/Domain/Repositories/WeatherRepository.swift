//
//  WeatherRepository.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 30/10/2022.
//

protocol WeatherRepository {
    @discardableResult
    func fetchWeatherList(query: WeatherQuery,
                          page: Int,
                         cached: @escaping (WeatherPage) -> Void,
                         completion: @escaping (Result<WeatherPage, Error>) -> Void) -> Cancellable?
}

