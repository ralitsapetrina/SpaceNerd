//
//  DoubleExtension.swift
//  Space Nerd
//
//  Created by Ralitsa Petrina on 12.10.20.
//  Copyright © 2020 Ralitsa Petrina. All rights reserved.
//

import Foundation

extension Double {
    func formattedAsTemperatureString() -> String {
        return String(format: "%.1f", self)  + " " + "°"
    }
    
    func formattedAsWindSpeedString() -> String {
        return String(format: "%.0f", self.mpsToKmph()) + " " + "km/hr"
    }
    
    func formattedAsAtmPressureString() -> String {
        return String(format: "%.1f", self.convertToHectopascal())  + " " + "hPa"
    }
}
