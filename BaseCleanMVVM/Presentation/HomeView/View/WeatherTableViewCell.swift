//
//  WeatherTableViewCell.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 29/10/2022.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: WeatherTableViewCell.self)
    static let height = CGFloat(148)
    
    @IBOutlet private weak var lblDate: UILabel!
    @IBOutlet private weak var lblAverageTemp: UILabel!
    @IBOutlet private weak var lblPressure: UILabel!
    @IBOutlet private weak var lblHumidity: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    
    private var viewModel: WeatherListItemViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(with viewModel: WeatherListItemViewModel) {
        self.viewModel = viewModel
        lblDate.text = viewModel.date
        lblAverageTemp.text = viewModel.averageTemp
        lblPressure.text = viewModel.pressure
        lblHumidity.text = viewModel.humidity
        lblDescription.text = viewModel.desc
    }

}
