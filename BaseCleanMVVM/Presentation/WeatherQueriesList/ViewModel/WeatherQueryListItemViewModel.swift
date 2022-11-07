//
//  WeatherQueryListItemViewModel.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//

class WeatherQueryListItemViewModel {
    let query: String

    init(query: String) {
        self.query = query
    }
}

extension WeatherQueryListItemViewModel: Equatable {
    static func == (lhs: WeatherQueryListItemViewModel, rhs: WeatherQueryListItemViewModel) -> Bool {
        return lhs.query == rhs.query
    }
}
