//
//  ViewController.swift
//  Space Nerd
//
//  Created by Petrina on 30.09.19.
//  Copyright © 2019 Ralitsa Petrina. All rights reserved.
//

import Foundation
import UIKit

class MarsWeatherViewController: UIViewController {

    var weatherDict: Dictionary<String, Any> = [:]
    var solItems: Array<SolDataItem>?
    @IBOutlet weak var solsTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadSolItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTableView()
    }
    
    func loadSolItems() {
        InsightData.solManager.getInsightData() {
            result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    let alert = UIAlertController(title: "An error occured", message: error.localizedDescription, preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                case .success(let solArray):
                    self.solItems = solArray
                }
                self.solsTable.reloadData()
            }
            
        }
    }
    
    func setUpTableView() {
        self.solsTable.delegate = self
        self.solsTable.dataSource = self
        let nib = UINib(nibName: "SingleSolCell", bundle: nil)
        solsTable.register(nib, forCellReuseIdentifier: "SingleSolCell")
    }
}

extension MarsWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let solsCount = solItems?.count {
            return solsCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleSolCell") as! SingleSolCell
        cell.backgroundColor = .clear
        cell.currentSol = solItems?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let myCell = cell as? SingleSolCell {
            myCell.configureCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

