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
        let accessString = "https: //api.nasa.gov/insight_weather/?api_key=\(API_KEY)&feedtype=json&ver=1.0"
        guard let accessURL = URL(string: accessString) else {fatalError()}
        self.accessURL = accessURL
    }
    
    
    func getInsightData(completion: @escaping(Result<solData, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: accessURL) {data, response, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.serverError))
                return
            }
            if error != nil || data == nil {
                completion(.failure(.clientError))
                return
            }
            do {
                let decoder = JSONDecoder()
                let dataResponse = try decoder.decode(solData.self, from: jsonData)
                let weatherResponseData = dataResponse
                completion(.success(weatherResponseData))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
