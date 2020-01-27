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
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            // Make it card-like
            containerView.layer.cornerRadius = 10
            containerView.layer.shadowOpacity = 1
            containerView.layer.shadowRadius = 4.0
            containerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        }
            
    }
}


