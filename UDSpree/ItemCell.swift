//
//  ItemCell.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/15/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var ivItem: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    
    func configure (item: Item) {
        DispatchQueue.main.async {
            self.ivItem.image = item.itemImage
        }
        
        lblTitle.text = item.itemTitle
        lblPrice.text = (item.itemPrice! + " $")
    }
    
}


