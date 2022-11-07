//
//  WeatherQueriesItemCell.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//
import UIKit

final class WeatherQueriesItemCell: UITableViewCell {
    static let height = CGFloat(50)
    static let reuseIdentifier = String(describing: WeatherQueriesItemCell.self)

    @IBOutlet private var titleLabel: UILabel!
    
    func fill(with suggestion: WeatherQueryListItemViewModel) {
        self.titleLabel.text = suggestion.query
    }
}
