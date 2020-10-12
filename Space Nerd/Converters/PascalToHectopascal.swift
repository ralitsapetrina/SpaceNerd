//
//  PascalToHectopascal.swift
//  Space Nerd
//
//  Created by Ralitsa Petrina on 28.08.20.
//  Copyright © 2020 Ralitsa Petrina. All rights reserved.
//

import Foundation

extension Double {
    func convertToHectopascal() -> Double {
        let hPa = self * 0.01
        return hPa
    }
}
