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
    
    func makeWeatherListViewController() -> HomeViewController {
        return HomeViewController.create()
    }
    
}

extension WeatherSceneDIContainer: WeatherSearchFlowCoordinatorDependencies {}
