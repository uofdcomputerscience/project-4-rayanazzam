//
//  ItemCellP.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 1/26/20.
//  Copyright © 2020 Rayan Ahmed. All rights reserved.
//

import UIKit

class ItemCellP: UICollectionViewCell {
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
