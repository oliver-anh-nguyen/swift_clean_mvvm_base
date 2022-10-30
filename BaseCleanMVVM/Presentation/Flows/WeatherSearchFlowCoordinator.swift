//
//  WeatherSearchFlowCoordinator.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 30/10/2022.
//

import UIKit

protocol WeatherSearchFlowCoordinatorDependencies  {
    func makeWeatherListViewController() -> HomeViewController
}

final class WeatherSearchFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: WeatherSearchFlowCoordinatorDependencies

    private weak var moviesListVC: HomeViewController?
    
    init(navigationController: UINavigationController,
         dependencies: WeatherSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let vc = dependencies.makeWeatherListViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
