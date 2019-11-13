//
//  ViewController.swift
//  Space Nerd
//
//  Created by Petrina on 30.09.19.
//  Copyright © 2019 Ralitsa Petrina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var connectionError: Bool = false
    var weatherDict: Dictionary<String, Any> = [:]
    var solKeys: Array<String> = []
    var mostCommonDataKey: String = "most_common"


    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMarsData()
        let myDay = createSolDataObject(dataDict: weatherDict[solKeys[1]] as! Dictionary<String, Any>)
        print(myDay.horizontalWindSpeed.avarageValue)
        let myDayWindData = MostCommonWindDirection(windDataDict: myDay.windDirection[mostCommonDataKey] as! Dictionary<String, Any>)
        print(myDayWindData.compassPoint)
    }

    
    func fetchMarsData() -> Void {
        let dataRequast = InsightDataRequest()
        dataRequast.getInsightData() { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.weatherDict = weather
                if let solKeysArray = weather["sol_keys"] as? Array<String> {
                    self?.solKeys = solKeysArray
                }
            }
        }
    }
    
    func createSolDataObject(dataDict: Dictionary<String, Any>) -> SolData {
        let mySolData = SolData(solDict: dataDict)
        return mySolData
    }
}

