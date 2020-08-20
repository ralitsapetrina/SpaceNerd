//
//  SolData.swift
//  Space Nerd
//
//  Created by Ralitsa Petrina on 20.07.20.
//  Copyright © 2020 Ralitsa Petrina. All rights reserved.
//

import Foundation

class SolDataItem {
    let avgTemp: Double
    let minTemp: Double
    let maxTemp: Double
    let avgWindSpeed: Double
    let lasUTC: String
    let avgAtmPressure: Double
    let tempValidity: Bool?
    let windSpeedValidity: Bool?
    let atmPressureValidity: Bool?
    
    init(avgTemp: Double, minTemp: Double, maxTemp: Double, avgWindSpeed: Double, lasUTC: String, avgAtmPressure: Double, tempValidity: Bool, windSpeedValidity: Bool, atmPressureValidity: Bool) {
        self.avgTemp = avgTemp
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.avgWindSpeed = avgWindSpeed
        self.lasUTC = lasUTC
        self.avgAtmPressure = avgAtmPressure
        self.tempValidity = tempValidity
        self.windSpeedValidity = windSpeedValidity
        self.atmPressureValidity = atmPressureValidity
    }
    
    
}
