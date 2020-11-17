//
//  InsightHTTPRequest.swift
//  Space Nerd
//
//  Created by Petrina on 30.09.19.
//  Copyright © 2019 Ralitsa Petrina. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case noDataAvailable
    case canNotProcessData
    case serverError
    case clientError
}

class InsightData {
    var accessURL: URL
    let API_KEY: String = "WOg9jKQHhfPcbY9apcwVVItF9bCGyD9xonVvpCPC"
    var connectionError: Bool = false
    var solKeys: Array<String> = []
    var validityChecks: Dictionary<String, Any> = [:]
    static let solManager = InsightData()
    
    
    init() {
        let accessString = "https://api.nasa.gov/insight_weather/?api_key=\(API_KEY)&feedtype=json&ver=1.0"
        guard let accessURL = URL(string: accessString) else {fatalError()}
        self.accessURL = accessURL
    }
    
    
    func getInsightData(completion: @escaping(Result<Array<SolDataItem>, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: accessURL) {data, response, error in
            
            DispatchQueue.main.async {
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    print("data error")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(.failure(.serverError))
                    print("response error")
                    return
                }
                if error != nil || data == nil {
                    completion(.failure(.clientError))
                    return
                }
                do {
                    if let dataResponse = try JSONSerialization.jsonObject(with: jsonData, options: []) as? Dictionary<String, Any> {
                        
                        self.getSolKeys(with: dataResponse["sol_keys"] as? Array<String>)
                        self.getValidityChecks(with: dataResponse["validity_checks"] as? Dictionary<String, Any>)
                        
                        let dataArray = self.getSolData(with: dataResponse)
                        
                        completion(.success(dataArray))
                    }
                }catch{
                    completion(.failure(.canNotProcessData))
                    print("json failed")
                }
            }
        }
        print(accessURL)
        dataTask.resume()
    }
    
    func getSolKeys(with array: Array<String>?) {
        if let keysArray = array {
            self.solKeys = keysArray
        }
    }
    
    func getValidityChecks(with dict: Dictionary<String, Any>?) {
        if let validityDict = dict {
            self.validityChecks = validityDict
        }
    }
    
    func getSolData(with data: Dictionary<String, Any>) -> Array<SolDataItem>{
        var mySols: Array<SolDataItem> = []
        for sol in self.solKeys {
            let mySolDataObject = self.createSolDataObject(dataDict: data[sol] as? Dictionary<String, Any> ?? [:])
            let myValidityCheckObject = self.createValidityCheckObject(validityChecks: self.validityChecks[sol] as? Dictionary<String, Any> ?? [:])
            mySols.append(self.createSolDataItem(solData: mySolDataObject, validityChecks: myValidityCheckObject, forSol: sol))
        }
        return mySols
    }

    func createSolDataObject(dataDict: Dictionary<String, Any>) -> SolData {
        let mySol = SolData(solDict: dataDict)
        return mySol
    }
    
    func createValidityCheckObject(validityChecks: Dictionary<String, Any>) -> ValidityChecks {
        let checkValidity = ValidityChecks(validationDictPerItem: validityChecks)
        return checkValidity
    }
    
    func createSolDataItem(solData: SolData, validityChecks: ValidityChecks, forSol: String) -> SolDataItem {
        let mySolData = SolDataItem(solNum: forSol, avgTemp: solData.atmosphericTemperature.avarageValue, minTemp: solData.atmosphericTemperature.minValue, maxTemp: solData.atmosphericTemperature.maxValue, avgWindSpeed: solData.horizontalWindSpeed.avarageValue, firstUTC: solData.firstUTC, avgAtmPressure: solData.atmosphericPressure.avarageValue, tempValidity: validityChecks.atmosphericTemperatureCheck.isValid, windSpeedValidity: validityChecks.horizontalWindSpeedCheck.isValid, atmPressureValidity: validityChecks.atmosphericPressure.isValid)
        return mySolData
    }
}
