//
//  WeatherTableViewCell.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 29/10/2022.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var lblDate: UILabel!
    @IBOutlet private weak var lblAverageTemp: UILabel!
    @IBOutlet private weak var lblPressure: UILabel!
    @IBOutlet private weak var lblHumidity: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
