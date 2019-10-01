//
//  InsightWeatherData.swift
//  Space Nerd
//
//  Created by Petrina on 30.09.19.
//  Copyright © 2019 Ralitsa Petrina. All rights reserved.
//

import Foundation


struct insightData: Decodable {
    var sol0: solData
    var sol1: solData
    var sol2: solData
    var sol3: solData
    var sol4: solData
    var sol5: solData
    var sol6: solData
    var sol_keys: Array<Int>
    var validity_checks: validityChecks

}

struct validityChecks: Decodable {
    
}

struct solData: Decodable {
    var AT: tempData  // temperature data
    var HWS: tempData // horizontal wind speed data
    var PRE: tempData // atmospheric pressur data
    var Season: String
}

struct tempData: Decodable {
    var av: Float
    var ct: Int
    var mn: Float
    var mx: Float
}
