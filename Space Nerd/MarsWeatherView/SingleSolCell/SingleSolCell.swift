//
//  SingleSolCell.swift
//  Space Nerd
//
//  Created by Petrina on 13.11.19.
//  Copyright © 2019 Ralitsa Petrina. All rights reserved.
//

import UIKit

class SingleSolCell: UITableViewCell {
    
    @IBOutlet weak var solNumber: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var solValidation: UIImageView!
    @IBOutlet weak var avgTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var avgWindSpeed: UILabel!
    @IBOutlet weak var avgAtmPressure: UILabel!
    
    let parent = MarsWeatherViewController()
    var currentSol: SolDataItem?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        print("configureCell")
        if let currenSolItem = self.currentSol {
            print("if let currenSolItem = self.currentSol")
            solNumber.text = "Sol \(currenSolItem.solNum)"
            currentDate.text = "28 Aug."
            avgTemp.text = "\(currenSolItem.avgTemp)"
            maxTemp.text = "\(currenSolItem.maxTemp)"
            minTemp.text = "\(currenSolItem.minTemp)"
            avgWindSpeed.text = "\(currenSolItem.avgWindSpeed)"
            avgAtmPressure.text = "\(currenSolItem.avgAtmPressure)"
        }
    }

}
