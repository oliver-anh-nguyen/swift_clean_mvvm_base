//
//  DefaultWeatherQueriesRepository.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//

final class DefaultWeatherQueriesRepository {
    
}

extension DefaultWeatherQueriesRepository: WeatherQueriesRepository {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[WeatherQuery], Error>) -> Void) {
    
    }
    
    func saveRecentQuery(query: WeatherQuery, completion: @escaping (Result<WeatherQuery, Error>) -> Void) {
        
    }
}
