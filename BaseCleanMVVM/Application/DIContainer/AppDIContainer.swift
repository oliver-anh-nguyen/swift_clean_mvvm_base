//
//  AppDIContainer.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 29/10/2022.
//

import Foundation

final class AppDIContainer {
    
    final var appConfiguration = AppConfigurations()
    
    // MARK: - DIContainers of scenes
    func makeWeatherSceneDIContainer() -> WeatherSceneDIContainer {
        return WeatherSceneDIContainer()
    }
    
}
