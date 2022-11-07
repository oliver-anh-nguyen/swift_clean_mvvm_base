//
//  WeatherSceneDIContainer.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 30/10/2022.
//

import UIKit

final class WeatherSceneDIContainer {
    
    func makeWeatherSearchFlowCoordinator(navigationController: UINavigationController) -> WeatherSearchFlowCoordinator {
        return WeatherSearchFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    // MARK: - Weather List
    func makeWeatherListViewController(actions: WeatherListViewModelActions) -> HomeViewController {
        return HomeViewController.create(with: makeWeatherListViewModel(actions: actions))
    }
    
    func makeWeatherListViewModel(actions: WeatherListViewModelActions) -> WeatherListViewModel {
        return DefaultWeatherListViewModel(searchWeatherUseCase: makeSearchWeatherUseCase(),
                                          actions: actions)
    }
    
    // MARK: - Use Cases
    func makeSearchWeatherUseCase() -> SearchWeatherUseCase {
        return DefaultSearchWeatherUseCase(weatherRepository: makeWeatherRepository(),
                                           weatherQueriesRepository: makeWeatherQueriesRepository())
    }
    
    // MARK: - Repositories
    func makeWeatherRepository() -> WeatherRepository {
        return DefaultWeatherRepository()
    }
    func makeWeatherQueriesRepository() -> WeatherQueriesRepository {
        return DefaultWeatherQueriesRepository()
    }
    
}

extension WeatherSceneDIContainer: WeatherSearchFlowCoordinatorDependencies {}
