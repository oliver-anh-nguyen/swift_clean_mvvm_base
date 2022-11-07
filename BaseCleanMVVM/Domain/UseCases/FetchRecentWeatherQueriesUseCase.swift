//
//  FetchRecentWeatherQueriesUseCase.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 03/11/2022.
//

import Foundation

final class FetchRecentWeatherQueriesUseCase: UseCase {
    
    struct RequestValue {
        let maxCount: Int
    }
    
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
