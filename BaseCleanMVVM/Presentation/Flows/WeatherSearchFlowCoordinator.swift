//
//  WeatherSearchFlowCoordinator.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 30/10/2022.
//

import UIKit

protocol WeatherSearchFlowCoordinatorDependencies  {
    func makeWeatherListViewController(actions: WeatherListViewModelActions) -> HomeViewController
}

final class WeatherSearchFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: WeatherSearchFlowCoordinatorDependencies

    private weak var weatherListVC: HomeViewController?
    
    init(navigationController: UINavigationController,
         dependencies: WeatherSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let actions = WeatherListViewModelActions(showWeatherQueriesSuggestions: showWeatherQueriesSuggestions,
                                                  closeWeatherQueriesSuggestions: closeWeatherQueriesSuggestions)
        
        let vc = dependencies.makeWeatherListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func showWeatherQueriesSuggestions(didSelect: @escaping (WeatherQuery) -> Void) {
        
    }

    private func closeWeatherQueriesSuggestions() {
        
    }
}
