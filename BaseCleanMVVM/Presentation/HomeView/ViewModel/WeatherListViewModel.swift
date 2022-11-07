//
//  WeatherListViewModel.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 03/11/2022.
//

import Foundation

struct WeatherListViewModelActions {
    let showWeatherQueriesSuggestions: (@escaping (_ didSelect: WeatherQuery) -> Void) -> Void
    let closeWeatherQueriesSuggestions: () -> Void
}

enum WeatherListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol WeatherListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func showQueriesSuggestions()
    func closeQueriesSuggestions()
}

protocol WeatherListViewModelOutput {
    var items: Observable<[WeatherListItemViewModel]> { get }
    var loading: Observable<WeatherListViewModelLoading?> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

protocol WeatherListViewModel: WeatherListViewModelInput, WeatherListViewModelOutput {}

final class DefaultWeatherListViewModel: WeatherListViewModel {
    
    private let searchWeatherUseCase: SearchWeatherUseCase
    private let actions: WeatherListViewModelActions?
    
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    
    private var pages: [WeatherPage] = []
    private var weatherLoadTask: Cancellable? { willSet { weatherLoadTask?.cancel() } }
    
    // MARK: - OUTPUT

    let items: Observable<[WeatherListItemViewModel]> = Observable([])
    let loading: Observable<WeatherListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Movies", comment: "")
    
    init(searchWeatherUseCase: SearchWeatherUseCase, actions: WeatherListViewModelActions? = nil) {
        self.searchWeatherUseCase = searchWeatherUseCase
        self.actions = actions
    }
    
    private func appendPage(_ weatherPage: WeatherPage) {
        currentPage = weatherPage.page
        totalPageCount = weatherPage.totalPages
        
        pages = pages.filter { $0.page != weatherPage.page} + [weatherPage]
        
        items.value = pages.weathers.map(WeatherListItemViewModel.init)
    }
    
    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
        pages.removeAll()
        items.value.removeAll()
    }
    
    private func load(weatherQuery: WeatherQuery, loading: WeatherListViewModelLoading) {
        self.loading.value = loading
        query.value = weatherQuery.query

        weatherLoadTask = searchWeatherUseCase.execute(
            requestValue: .init(query: weatherQuery, page: nextPage),
            cached: appendPage,
            completion: { result in
                switch result {
                case .success(let page):
                    self.appendPage(page)
                case .failure(let error):
                    self.handle(error: error)
                }
                self.loading.value = .none
        })
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading movies", comment: "")
    }
    
    private func update(weatherQuery: WeatherQuery) {
        resetPages()
        load(weatherQuery: weatherQuery, loading: .fullScreen)
    }
}

// MARK: - INPUT. View event methods

extension DefaultWeatherListViewModel {

    func viewDidLoad() { }

    func didLoadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
        load(weatherQuery: .init(query: query.value),
             loading: .nextPage)
    }

    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(weatherQuery: WeatherQuery(query: query))
    }

    func didCancelSearch() {
        weatherLoadTask?.cancel()
    }

    func showQueriesSuggestions() {
        actions?.showWeatherQueriesSuggestions(update(weatherQuery:))
    }

    func closeQueriesSuggestions() {
        actions?.closeWeatherQueriesSuggestions()
    }
}

private extension Array where Element == WeatherPage {
    var weathers: [Weather] { flatMap { $0.weathers } }
}
