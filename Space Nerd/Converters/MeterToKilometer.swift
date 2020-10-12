//
//  MeterToKilometer.swift
//  Space Nerd
//
//  Created by Ralitsa Petrina on 28.08.20.
//  Copyright © 2020 Ralitsa Petrina. All rights reserved.
//

import Foundation

extension Double {
    func meterToKilometer() -> Double{
        let km = self * 0.001
        return km
    }
}
