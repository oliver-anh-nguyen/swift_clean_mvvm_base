//
//  FetchRecentWeatherQueriesUseCase.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 03/11/2022.
//

import Foundation

struct RequestValue {
    let maxCount: Int
}

final class FetchRecentWeatherQueriesUseCase: UseCase {
    
    typealias ResultValue = (Result<[WeatherQuery], Error>)
    
    private let requestValue: RequestValue
    private let completion: (ResultValue) -> Void
    private let weatherQueriesRepository: WeatherQueriesRepository
    
    init(requestValue: RequestValue,
         completion: @escaping(ResultValue) -> Void,
         weatherQueriesRepository: WeatherQueriesRepository) {
        self.requestValue = requestValue
        self.completion = completion
        self.weatherQueriesRepository = weatherQueriesRepository
    }
    
    func start() -> Cancellable? {
        weatherQueriesRepository.fetchRecentsQueries(maxCount: requestValue.maxCount, completion: completion)
        return nil
    }
}
