//
//  SingleSolCell.swift
//  Space Nerd
//
//  Created by Petrina on 13.11.19.
//  Copyright © 2019 Ralitsa Petrina. All rights reserved.
//

import UIKit

class SingleSolCell: UITableViewCell {
    
    @IBOutlet weak var solNumber: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var solValidation: UIImageView!
    @IBOutlet weak var avgTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var avgWindSpeed: UILabel!
    @IBOutlet weak var avgAtmPressure: UILabel!
    @IBOutlet weak var tempValidator: UIImageView!
    @IBOutlet weak var windValidator: UIImageView!
    @IBOutlet weak var pressureValidator: UIImageView!
    
    
    let parent = MarsWeatherViewController()
    var currentSol: SolDataItem?
    var generalValidation: Bool = true

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureCell()
    }
    
    func getValidatorColor(for validator: Bool?) -> UIColor{
        if let isValid = validator {
            if isValid {
                return UIColor.systemGreen
            } else {
                self.generalValidation = false
                return UIColor.systemRed
            }
        }
        self.generalValidation = false
        return UIColor.gray
    }
    
    func getGeneralValidatorColor() -> UIColor {
        if generalValidation {
            return UIColor.systemGreen
        } else {
            return UIColor.systemRed
        }
    }
    
    func configureCell() {
        if let currentSolItem = self.currentSol {
            solNumber.text = "Sol \(currentSolItem.solNum)"
            currentDate.text = currentSolItem.firstUTC.fromUTCToDateMonthString()
            avgTemp.text = currentSolItem.avgTemp.formattedAsTemperatureString()
            maxTemp.text = currentSolItem.maxTemp.formattedAsTemperatureString()
            minTemp.text = currentSolItem.minTemp.formattedAsTemperatureString()
            avgWindSpeed.text = currentSolItem.avgWindSpeed.formattedAsWindSpeedString()
            avgAtmPressure.text = currentSolItem.avgAtmPressure.formattedAsAtmPressureString()
            tempValidator.tintColor = getValidatorColor(for: currentSolItem.tempValidity)
            windValidator.tintColor = getValidatorColor(for: currentSolItem.windSpeedValidity)
            pressureValidator.tintColor = getValidatorColor(for: currentSolItem.atmPressureValidity)
            solValidation.tintColor = getGeneralValidatorColor()
        }
    }

}
