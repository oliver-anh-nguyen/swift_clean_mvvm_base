//
//  AppDIContainer.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 29/10/2022.
//

import Foundation

final class AppDIContainer {
    
    final var appConfiguration = AppConfigurations()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,
                                          queryParameters: ["appid": appConfiguration.apiKey,
                                                            "language": NSLocale.preferredLanguages.first ?? "en"])
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    func makeWeatherSceneDIContainer() -> WeatherSceneDIContainer {
        let dependencies = WeatherSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return WeatherSceneDIContainer(dependencies: dependencies)
    }
    
}
