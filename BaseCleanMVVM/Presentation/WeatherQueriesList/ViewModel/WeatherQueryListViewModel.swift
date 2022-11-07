//
//  WeatherQueryListViewModel.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//

typealias WeatherQueryListViewModelDidSelectAction = (WeatherQuery) -> Void

protocol WeatherQueryListViewModelInput {
    func viewWillAppear()
    func didSelect(item: WeatherQueryListItemViewModel)
}

protocol WeatherQueryListViewModelOutput {
    var items: Observable<[WeatherQueryListItemViewModel]> { get }
}

protocol WeatherQueryListViewModel: WeatherQueryListViewModelInput, WeatherQueryListViewModelOutput { }

typealias FetchRecentWeatherQueriesUseCaseFactory = (
    FetchRecentWeatherQueriesUseCase.RequestValue,
    @escaping (FetchRecentWeatherQueriesUseCase.ResultValue) -> Void
    ) -> UseCase

final class DefaultWeatherQueryListViewModel: WeatherQueryListViewModel {

    private let numberOfQueriesToShow: Int
    private let fetchRecentWeatherQueriesUseCaseFactory: FetchRecentWeatherQueriesUseCaseFactory
    private let didSelect: WeatherQueryListViewModelDidSelectAction?
    
    // MARK: - OUTPUT
    let items: Observable<[WeatherQueryListItemViewModel]> = Observable([])
    
    init(numberOfQueriesToShow: Int,
         fetchRecentWeatherQueriesUseCaseFactory: @escaping FetchRecentWeatherQueriesUseCaseFactory,
         didSelect: WeatherQueryListViewModelDidSelectAction? = nil) {
        self.numberOfQueriesToShow = numberOfQueriesToShow
        self.fetchRecentWeatherQueriesUseCaseFactory = fetchRecentWeatherQueriesUseCaseFactory
        self.didSelect = didSelect
    }
    
    private func updateWeatherQueries() {
        let request = FetchRecentWeatherQueriesUseCase.RequestValue(maxCount: numberOfQueriesToShow)
        let completion: (FetchRecentWeatherQueriesUseCase.ResultValue) -> Void = { result in
            switch result {
            case .success(let items):
                self.items.value = items.map { $0.query }.map(WeatherQueryListItemViewModel.init)
            case .failure: break
            }
        }
        let useCase = fetchRecentWeatherQueriesUseCaseFactory(request, completion)
        useCase.start()
    }
}

// MARK: - INPUT. View event methods
extension DefaultWeatherQueryListViewModel {
        
    func viewWillAppear() {
        updateWeatherQueries()
    }
    
    func didSelect(item: WeatherQueryListItemViewModel) {
        didSelect?(WeatherQuery(query: item.query))
    }
}
