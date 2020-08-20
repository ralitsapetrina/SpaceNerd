//
//  ViewController.swift
//  Space Nerd
//
//  Created by Petrina on 30.09.19.
//  Copyright © 2019 Ralitsa Petrina. All rights reserved.
//

import UIKit

class MarsWeatherViewController: UIViewController {

    var weatherDict: Dictionary<String, Any> = [:]
    var solItems: Array<SolDataItem>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadSolItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
    }
    
    func loadSolItems() {
        InsightData.solManager.getInsightData() {
            result in
            switch result {
            case .failure(let error):
                let alert = UIAlertController(title: "An error occured", message: error.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            case .success(let solArray):
                self.solItems = solArray
            }
        }
    }
     
    @IBAction func btnTap(_ sender: Any) {
        if let myArray = self.solItems {
            print(myArray[0].avgTemp)
        } else {
            print("something happened.... ")
        }
    }
}

