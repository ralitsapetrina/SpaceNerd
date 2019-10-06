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

struct InsightDataRequest: Decodable {
    var accessURL: URL
    let API_KEY: String = "WOg9jKQHhfPcbY9apcwVVItF9bCGyD9xonVvpCPC"
    
    
    init() {
        let accessString = "https://api.nasa.gov/insight_weather/?api_key=\(API_KEY)&feedtype=json&ver=1.0"
        guard let accessURL = URL(string: accessString) else {fatalError()}
        self.accessURL = accessURL
    }
    
    
    func getInsightData(completion: @escaping(Result<Dictionary<String, Any>, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: accessURL) {data, response, error in
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
                let dataResponse = try JSONSerialization.jsonObject(with: jsonData, options: []) as? Dictionary<String, Any>
                let weatherDataResponse = dataResponse
                completion(.success(weatherDataResponse ?? [:]))
            }catch{
                completion(.failure(.canNotProcessData))
                print("json failed")
            }
        }
        dataTask.resume()
    }
}
