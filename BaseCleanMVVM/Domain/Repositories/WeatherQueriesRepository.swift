//
//  WeatherQueriesRepository.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 30/10/2022.
//

protocol WeatherQueriesRepository {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[WeatherQuery], Error>) -> Void)
    func saveRecentQuery(query: WeatherQuery, completion: @escaping (Result<WeatherQuery, Error>) -> Void)
}
