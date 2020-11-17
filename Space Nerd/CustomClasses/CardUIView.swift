//
//  CardUIView.swift
//  Space Nerd
//
//  Created by Ralitsa Petrina on 17.11.20.
//  Copyright © 2020 Ralitsa Petrina. All rights reserved.
//

import Foundation
import UIKit

class CardUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpView()
    }
    
    func setUpView() {
        self.backgroundColor = UIColor(named: "CardUIViewColor")
        let viewLayer = self.layer
        viewLayer.cornerRadius = 20
        viewLayer.shadowColor = UIColor(named: "CardUIViewShadowColor")?.cgColor
        viewLayer.shadowOffset = CGSize(width: 4, height: 4)
        viewLayer.shadowOpacity = 1
        viewLayer.shadowRadius = 5
    }
    
}
