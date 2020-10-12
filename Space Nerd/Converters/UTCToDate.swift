//
//  UTCToDate.swift
//  Space Nerd
//
//  Created by Ralitsa Petrina on 28.08.20.
//  Copyright © 2020 Ralitsa Petrina. All rights reserved.
//

import Foundation

extension String {
    func fromUTCToDateMonthString() -> String {
        var convertedUTC = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //"2019-08-20T08:43:34Z"
        let currentDate = formatter.date(from: self)
//        let secFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "bg_BG")
        formatter.dateFormat = "d MMM"
        convertedUTC = formatter.string(from: currentDate!)
        
        return convertedUTC
    }
}
