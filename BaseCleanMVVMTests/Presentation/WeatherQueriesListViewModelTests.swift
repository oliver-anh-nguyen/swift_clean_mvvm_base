//
//  WeatherQueriesListViewModelTests.swift
//  BaseCleanMVVMTests
//
//  Created by AnhNguyen on 06/11/2022.
//

import XCTest
@testable import BaseCleanMVVM

class WeatherQueriesListViewModelTests: XCTestCase {
    
    private enum FetchRecentQueriedUseCase: Error {
        case someError
    }
    
    var weatherQueries = [WeatherQuery(query: "London"),
                        WeatherQuery(query: "Paris"),
                        WeatherQuery(query: "Chicago"),
                        WeatherQuery(query: "Seoul"),
                        WeatherQuery(query: "Berlin")]

    class FetchRecentWeatherQueriesUseCaseMock: UseCase {
        var expectation: XCTestExpectation?
        var error: Error?
        var weatherQueries: [WeatherQuery] = []
        var completion: (Result<[WeatherQuery], Error>) -> Void = { _ in }

        func start() -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(weatherQueries))
            }
            expectation?.fulfill()
            return nil
        }
    }

    func makeFetchRecentWeatherQueriesUseCase(_ mock: FetchRecentWeatherQueriesUseCaseMock) -> FetchRecentWeatherQueriesUseCaseFactory {
        return { _, completion in
            mock.completion = completion
            return mock
        }
    }
    
    func test_whenFetchRecentWeatherQueriesUseCaseReturnsQueries_thenShowTheseQueries() {
        // given
        let useCase = FetchRecentWeatherQueriesUseCaseMock()
        useCase.expectation = self.expectation(description: "Recent query fetched")
        useCase.weatherQueries = weatherQueries
        let viewModel = DefaultWeatherQueryListViewModel(numberOfQueriesToShow: 3,
                                                         fetchRecentWeatherQueriesUseCaseFactory: makeFetchRecentWeatherQueriesUseCase(useCase))

        // when
        viewModel.viewWillAppear()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.items.value.map { $0.query }, weatherQueries.map { $0.query })
    }
    
    func test_whenFetchRecentWeatherQueriesUseCaseReturnsError_thenDontShowAnyQuery() {
        // given
        let useCase = FetchRecentWeatherQueriesUseCaseMock()
        useCase.expectation = self.expectation(description: "Recent query fetched")
        useCase.error = FetchRecentQueriedUseCase.someError
        let viewModel = DefaultWeatherQueryListViewModel(numberOfQueriesToShow: 3,
                                                         fetchRecentWeatherQueriesUseCaseFactory: makeFetchRecentWeatherQueriesUseCase(useCase))
        
        // when
        viewModel.viewWillAppear()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(viewModel.items.value.isEmpty)
    }
    
    func test_whenDidSelectQueryEventIsReceived_thenCallDidSelectAction() {
        // given
        let selectedQueryItem = WeatherQuery(query: "London")
        var actionWeatherQuery: WeatherQuery?
        let expectation = self.expectation(description: "Delegate notified")
        let didSelect: WeatherQueryListViewModelDidSelectAction = { weatherQuery in
            actionWeatherQuery = weatherQuery
            expectation.fulfill()
        }
        
        let viewModel = DefaultWeatherQueryListViewModel(numberOfQueriesToShow: 3,
                                                         fetchRecentWeatherQueriesUseCaseFactory: makeFetchRecentWeatherQueriesUseCase(FetchRecentWeatherQueriesUseCaseMock()),
                                                        didSelect: didSelect)
        
        // when
        viewModel.didSelect(item: WeatherQueryListItemViewModel(query: selectedQueryItem.query))
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(actionWeatherQuery, selectedQueryItem)
    }
}
