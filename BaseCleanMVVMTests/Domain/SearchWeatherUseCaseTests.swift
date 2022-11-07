//
//  SearchWeatherUseCaseTests.swift
//  BaseCleanMVVMTests
//
//  Created by AnhNguyen on 06/11/2022.
//

import XCTest
@testable import BaseCleanMVVM

class SearchWeatherUseCaseTests: XCTestCase {
    static let weatherPages: [WeatherPage] = {
        let page1 = WeatherPage(page: 1, totalPages: 1, weathers: [
            Weather.stub(weathers: [WeatherItem.stub(des: "heavy rain"), WeatherItem.stub(des:"light rain")], temp: Temperature.stub(min: 100.20, max: 50.9)),
            Weather.stub(weathers: [WeatherItem.stub()], temp: Temperature.stub())
        ])
        let page2 = WeatherPage(page: 1, totalPages: 1, weathers: [
            Weather.stub(weathers: [WeatherItem.stub(des: "heavy"), WeatherItem.stub(des:"light")], temp: Temperature.stub(min: 200.20, max: 100.9))
        ])

        return [page1, page2]
    }()
    
    enum WeatherRepositorySuccessTestError: Error {
        case failedFetching
    }
    
    class WeatherQueriesRepositoryMock: WeatherQueriesRepository {
        var recentQueries: [WeatherQuery] = []
        func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[WeatherQuery], Error>) -> Void) {
            completion(.success(recentQueries))
        }
        
        func saveRecentQuery(query: WeatherQuery, completion: @escaping (Result<WeatherQuery, Error>) -> Void) {
            recentQueries.append(query)
        }
    }
    
    struct WeatherRepositoryMock: WeatherRepository {
        var result: Result<WeatherPage, Error>
        func fetchWeatherList(query: WeatherQuery, page: Int, cached: @escaping (WeatherPage) -> Void, completion: @escaping (Result<WeatherPage, Error>) -> Void) -> Cancellable? {
            completion(result)
            return nil
        }
    }
    
    func testSearchWeatherUseCase_whenSuccessfullyFetcheWeatherForQuery_thenQueryIsSavedInRecentQueries() {
        // given
        let expectation = self.expectation(description: "Recent query saved")
        expectation.expectedFulfillmentCount = 2
        let weatherQueriesRepository = WeatherQueriesRepositoryMock()
        let useCase = DefaultSearchWeatherUseCase(weatherRepository: WeatherRepositoryMock(result: .success(SearchWeatherUseCaseTests.weatherPages[0])), weatherQueriesRepository: weatherQueriesRepository)

        // when
        let requestValue = SearchWeatherUseCaseRequestValue(query: WeatherQuery(query: "London"),
                                                           page: 0)
        _ = useCase.execute(requestValue: requestValue, cached: { _ in }) { _ in
            expectation.fulfill()
        }
        // then
        var recents = [WeatherQuery]()
        weatherQueriesRepository.fetchRecentsQueries(maxCount: 1) { result in
            recents = (try? result.get()) ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(recents.contains(WeatherQuery(query: "London")))
    }
    
    func testSearchWeatherUseCase_whenFailedFetchingWeatherForQuery_thenQueryIsNotSavedInRecentQueries() {
        // given
        let expectation = self.expectation(description: "Recent query should not be saved")
        expectation.expectedFulfillmentCount = 2
        let weatherQueriesRepository = WeatherQueriesRepositoryMock()
        let useCase = DefaultSearchWeatherUseCase(weatherRepository: WeatherRepositoryMock(result: .failure(WeatherRepositorySuccessTestError.failedFetching)),
                                                  weatherQueriesRepository: weatherQueriesRepository)
        
        // when
        let requestValue = SearchWeatherUseCaseRequestValue(query: WeatherQuery(query: "London"),
                                                           page: 0)
        _ = useCase.execute(requestValue: requestValue, cached: { _ in }) { _ in
            expectation.fulfill()
        }
        // then
        var recents = [WeatherQuery]()
        weatherQueriesRepository.fetchRecentsQueries(maxCount: 1) { result in
            recents = (try? result.get()) ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(recents.isEmpty)
    }
}
