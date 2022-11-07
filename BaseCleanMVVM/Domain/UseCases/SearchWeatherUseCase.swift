//
//  SearchWeatherUseCase.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 30/10/2022.
//

import Foundation

protocol SearchWeatherUseCase {
    func execute(requestValue:SearchWeatherUseCaseRequestValue,
                 cached: @escaping (WeatherPage) -> Void,
                 completion: @escaping (Result<WeatherPage, Error>) -> Void) -> Cancellable?
}

struct SearchWeatherUseCaseRequestValue {
    let query: WeatherQuery
    let page: Int
}

final class DefaultSearchWeatherUseCase: SearchWeatherUseCase {
    
    typealias ResultValue = (Result<WeatherPage, Error>)
    
    private let weatherRepository: WeatherRepository
    private let weatherQueriesRepository: WeatherQueriesRepository
    
    init(weatherRepository: WeatherRepository,
         weatherQueriesRepository: WeatherQueriesRepository) {

        self.weatherRepository = weatherRepository
        self.weatherQueriesRepository = weatherQueriesRepository
    }
    
    func execute(requestValue: SearchWeatherUseCaseRequestValue,
                 cached: @escaping (WeatherPage) -> Void,
                 completion: @escaping (Result<WeatherPage, Error>) -> Void) -> Cancellable? {
        return weatherRepository.fetchWeatherList(query: requestValue.query, page: requestValue.page, cached: cached) { result in
            if case .success = result {
                self.weatherQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }
            completion(result)
        }
    }
}
