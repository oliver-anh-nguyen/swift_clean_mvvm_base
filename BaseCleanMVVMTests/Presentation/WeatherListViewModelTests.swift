//
//  WeatherListViewModelTests.swift
//  BaseCleanMVVMTests
//
//  Created by AnhNguyen on 06/11/2022.
//

import XCTest
@testable import BaseCleanMVVM

class WeatherListViewModelTests: XCTestCase {
    private enum SearchWeatherUseCaseError: Error {
        case someError
    }
    
    let weathersPages: [WeatherPage] = {
        let page1 = WeatherPage(page: 1, totalPages: 1, weathers: [
            Weather.stub(weathers: [WeatherItem.stub(des: "heavy rain"), WeatherItem.stub(des:"light rain")], temp: Temperature.stub(min: 100.20, max: 50.9)),
            Weather.stub(weathers: [WeatherItem.stub()], temp: Temperature.stub()) ])
        let page2 = WeatherPage(page: 1, totalPages: 1, weathers: [
            Weather.stub(weathers: [WeatherItem.stub(des: "heavy"), WeatherItem.stub(des:"light")], temp: Temperature.stub(min: 200.20, max: 100.9))
        ])

        return [page1, page2]
    }()
    
    class SearchWeatherUseCaseMock: SearchWeatherUseCase {
        var expectation: XCTestExpectation?
        var error: Error?
        var page = WeatherPage(page: 0, totalPages: 0, weathers: [])
        
        func execute(requestValue: SearchWeatherUseCaseRequestValue,
                     cached: @escaping (WeatherPage) -> Void,
                     completion: @escaping (Result<WeatherPage, Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(page))
            }
            expectation?.fulfill()
            return nil
        }
    }
    
    func test_whenSearchWeatherUseCaseRetrievesFirstPage_thenViewModelContainsOnlyFirstPage() {
        // given
        let searchWeatherUseCaseMock = SearchWeatherUseCaseMock()
        searchWeatherUseCaseMock.expectation = self.expectation(description: "contains only first page")
        searchWeatherUseCaseMock.page = WeatherPage(page: 1, totalPages: 2, weathers: weathersPages[0].weathers)
        let viewModel = DefaultWeatherListViewModel(searchWeatherUseCase: searchWeatherUseCaseMock)
        // when
        viewModel.didSearch(query: "London")
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertTrue(viewModel.hasMorePages)
    }
    
    func test_whenSearchWeatherUseCaseRetrievesFirstAndSecondPage_thenViewModelContainsTwoPages() {
        // given
        let searchWeatherUseCaseMock = SearchWeatherUseCaseMock()
        searchWeatherUseCaseMock.expectation = self.expectation(description: "First page loaded")
        searchWeatherUseCaseMock.page = WeatherPage(page: 1, totalPages: 2, weathers: weathersPages[0].weathers)
        let viewModel = DefaultWeatherListViewModel(searchWeatherUseCase: searchWeatherUseCaseMock)
        // when
        viewModel.didSearch(query: "London")
        waitForExpectations(timeout: 5, handler: nil)
        
        searchWeatherUseCaseMock.expectation = self.expectation(description: "Second page loaded")
        searchWeatherUseCaseMock.page = WeatherPage(page: 2, totalPages: 2, weathers: weathersPages[1].weathers)
        
        viewModel.didLoadNextPage()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertFalse(viewModel.hasMorePages)
    }
    
    func test_whenSearchWeatherUseCaseReturnsError_thenViewModelContainsError() {
        // given
        let searchWeatherUseCaseMock = SearchWeatherUseCaseMock()
        searchWeatherUseCaseMock.expectation = self.expectation(description: "contain errors")
        searchWeatherUseCaseMock.error = SearchWeatherUseCaseError.someError
        let viewModel = DefaultWeatherListViewModel(searchWeatherUseCase: searchWeatherUseCaseMock)
        // when
        viewModel.didSearch(query: "London")
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
    
    func test_whenLastPage_thenHasNoPageIsTrue() {
        // given
        let searchWeatherUseCaseMock = SearchWeatherUseCaseMock()
        searchWeatherUseCaseMock.expectation = self.expectation(description: "First page loaded")
        searchWeatherUseCaseMock.page = WeatherPage(page: 1, totalPages: 2, weathers: weathersPages[0].weathers)
        let viewModel = DefaultWeatherListViewModel(searchWeatherUseCase: searchWeatherUseCaseMock)
        // when
        viewModel.didSearch(query: "London")
        waitForExpectations(timeout: 5, handler: nil)
        
        searchWeatherUseCaseMock.expectation = self.expectation(description: "Second page loaded")
        searchWeatherUseCaseMock.page = WeatherPage(page: 2, totalPages: 2, weathers: weathersPages[1].weathers)

        viewModel.didLoadNextPage()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertFalse(viewModel.hasMorePages)
    }
}
