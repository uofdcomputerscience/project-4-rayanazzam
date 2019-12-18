//
//  SignUpButton.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/18/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import Foundation

import UIKit

class SignUpButton: LogInButton {
    override func setupButton() { 
        backgroundColor     = Colors.blackRed
        titleLabel?.font    = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 22)
        layer.cornerRadius  = frame.size.height/2
        setTitleColor(.white, for: .normal)
    }
}
