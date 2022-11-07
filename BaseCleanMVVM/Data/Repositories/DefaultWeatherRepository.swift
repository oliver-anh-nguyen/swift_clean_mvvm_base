//
//  DefaultMoviesRepository.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//

final class DefaultWeatherRepository {
    
}

extension DefaultWeatherRepository: WeatherRepository {
    func fetchWeatherList(query: WeatherQuery, page: Int, cached: @escaping (WeatherPage) -> Void, completion: @escaping (Result<WeatherPage, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        return task
    }
}
