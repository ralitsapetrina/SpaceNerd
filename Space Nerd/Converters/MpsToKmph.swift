//
//  MpsToKmph.swift
//  Space Nerd
//
//  Created by Ralitsa Petrina on 28.08.20.
//  Copyright © 2020 Ralitsa Petrina. All rights reserved.
//

import Foundation

extension Double {
    func mpsToKmph() -> Double {
        let kmph = self * 3.6
        return kmph
    }
}
