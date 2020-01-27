//
//  ItemCell.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/15/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import UIKit
import Foundation
import Parse

class Item {
    var itemImage: UIImage?
    var itemTitle: String?
    var itemPrice: String?
    var itemDescription: String?
    var itemUser: PFUser?
    var itemId: String?
    var itemType: String?
    var itemLocation: String?
    
    func setImage(image: UIImage) {
        self.itemImage = image
    }
    
    func setTitle (title: String) {
        self.itemTitle = title
    }
    
    func setPrice (price: String) {
        self.itemPrice = price
    }
    
    func setUser (user: PFUser) {
        self.itemUser = user
    }
    
    func setDescription (description: String) {
        self.itemDescription = description
    }
    
    func setId (id: String) {
        self.itemId = id
    }
    
    func setType (type: String) {
        self.itemType = type
    }
    
    func setLocation (location: String) {
        self.itemLocation = location
    }
}


