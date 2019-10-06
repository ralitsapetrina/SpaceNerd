//
//  InsightWeatherData.swift
//  Space Nerd
//
//  Created by Petrina on 30.09.19.
//  Copyright © 2019 Ralitsa Petrina. All rights reserved.
//

import Foundation


struct SolData {
    var Season: String
    var horizontalWindSpeed: WeatherData // horizontal wind speed data
    var windDirection: Dictionary<String, Any>
    var atmosphericPressure: WeatherData // atmospheric pressur data
    var lastUTC: String
    var atmosphericTemperature: WeatherData // temperature data
    var firstUTC: String
    
    init(solDict: Dictionary<String, Any>) {
        self.Season = solDict["Season"] as! String
        self.horizontalWindSpeed = WeatherData(solDataDict: solDict["HWS"] as! Dictionary<String, Any>)
        self.windDirection = solDict["WD"] as! Dictionary<String, Any>
        self.atmosphericPressure = WeatherData(solDataDict: solDict["PRE"] as! Dictionary<String, Any>)
        self.lastUTC = solDict["Last_UTC"] as! String
        self.atmosphericTemperature = WeatherData(solDataDict: solDict["AT"] as! Dictionary<String, Any>)
        self.firstUTC = solDict["First_UTC"] as! String
    }
}


struct WeatherData {
    var avarageValue: Double
    var recordedSamplesOverSol: Int
    var minValue: Double
    var maxValue: Double
    
    init(solDataDict: Dictionary<String, Any>) {
        self.avarageValue = solDataDict["av"] as! Double
        self.recordedSamplesOverSol = solDataDict["ct"] as! Int
        self.minValue = solDataDict["mn"] as! Double
        self.maxValue = solDataDict["mx"] as! Double
    }
}


struct MostCommonWindDirection {
    var compassDegrees: Double
    var compassPoint: String
    var compassRight: Double
    var compassUp: Double
    var numberOfSamples: Int
    
    init(windDataDict: Dictionary<String, Any>) {
        self.compassDegrees = windDataDict["compass_degrees"] as! Double
        self.compassPoint = windDataDict["compass_point"] as! String
        self.compassRight = windDataDict["compass_right"] as! Double
        self.compassUp = windDataDict["compass_up"] as! Double
        self.numberOfSamples = windDataDict["ct"] as! Int
    }
}


struct ValidityChecks {
    var atmosphericTemperatureCheck: ValidationData
    var horizontalWindSpeedCheck: ValidationData
    var atmosphericPressure: ValidationData
    var windDirectionCheck: ValidationData
    
    init(validationDictPerItem: Dictionary<String, Any>) {
        self.atmosphericTemperatureCheck = ValidationData(validatonDict: validationDictPerItem["AT"] as! Dictionary<String, Any>)
        self.horizontalWindSpeedCheck = ValidationData(validatonDict: validationDictPerItem["HWS"] as! Dictionary<String, Any>)
        self.atmosphericPressure = ValidationData(validatonDict: validationDictPerItem["PRE"] as! Dictionary<String, Any>)
        self.windDirectionCheck = ValidationData(validatonDict: validationDictPerItem["WD"] as! Dictionary<String, Any>)
    }
}


struct ValidationData {
    var solHoursWithData: Array<Int>
    var isValid: Bool
    
    init(validatonDict: Dictionary<String, Any>) {
        self.solHoursWithData = validatonDict["sol_hours_with_data"] as! Array<Int>
        self.isValid = validatonDict["valid"] as! Bool
    }
}

