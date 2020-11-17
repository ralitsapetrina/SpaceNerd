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
    
    let parent = MarsWeatherViewController()
    var currentSol: SolDataItem?
    var cellNotConfigured: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        self.configureCell()
    }
    
    var isSolTempValid: Bool {
        if let currentSol = currentSol {
            return currentSol.isTempValid
        }
        return false
    }
    
    var isSolWindSpeedValid: Bool {
        if let currentSol = currentSol {
            return currentSol.isWindSpeedValid
        }
        return false
    }
    
    var isSolAtmPressureValid: Bool {
        if let currentSol = currentSol {
            return currentSol.isAtmPressureValid
        }
        return false
    }
    
    func isDataValid() -> Bool {
        if isSolTempValid && isSolWindSpeedValid && isSolAtmPressureValid {
            return true
        }
        return false
    }
    
    func getGeneralValidatorColor() -> UIColor {
        if isDataValid() {
            return UIColor.systemGreen
        } else {
            return UIColor.systemRed
        }
    }
    
    func changeColorsForNALabels(for labels: [UILabel]) {
        for label in labels {
            label.textColor = UIColor(named: "SpaceNAText")
        }
    }
    
    func changeColorsForNALabelsIfNeeded() {
        if !isSolTempValid {
            changeColorsForNALabels(for: [avgTemp, maxTemp, minTemp])
        }
        
        if !isSolWindSpeedValid {
            changeColorsForNALabels(for: [avgWindSpeed])
        }
        
        if !isSolAtmPressureValid {
            changeColorsForNALabels(for: [avgAtmPressure])
        }
    }
    
    func configureCell() {
        guard let currentSolItem = self.currentSol else {
            return
        }
        
        guard cellNotConfigured else {
            return
        }
        
        print("\(currentSolItem.solNum) configureCell")
        solNumber.text = "Sol \(currentSolItem.solNum)"
        currentDate.text = currentSolItem.firstUTC.fromUTCToDateMonthString()
        solValidation.tintColor = getGeneralValidatorColor()
        
        if isSolTempValid {
            avgTemp.text = currentSolItem.avgTemp.formattedAsTemperatureString()
            maxTemp.text = currentSolItem.maxTemp.formattedAsTemperatureString()
            minTemp.text = currentSolItem.minTemp.formattedAsTemperatureString()
        }
        
        if isSolWindSpeedValid {
            avgWindSpeed.text = currentSolItem.avgWindSpeed.formattedAsWindSpeedString()
        }
        
        if isSolAtmPressureValid {
            avgAtmPressure.text = currentSolItem.avgAtmPressure.formattedAsAtmPressureString()
        }
        
        self.changeColorsForNALabelsIfNeeded()
        cellNotConfigured = false
        
    }

}
