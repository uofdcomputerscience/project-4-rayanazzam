//
//  MyButton.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/18/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import Foundation
import UIKit


class LogInButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        backgroundColor     = Colors.brightRed 
        titleLabel?.font    = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 22)
        layer.cornerRadius  = frame.size.height/2
        setTitleColor(.white, for: .normal)
    }
}


struct Colors {
    static let brightRed = UIColor(red: 244/255, green: 44/255, blue: 0/255, alpha: 1.0)
    static let blackRed = UIColor(red: 63/255, green: 14/255, blue: 0/255, alpha: 1.0)
}


struct Fonts {
    static let avenirNextCondensedDemiBold = "AvenirNextCondensed-DemiBold"
}

