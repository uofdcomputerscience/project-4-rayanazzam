//
//  HomeViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/15/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import UIKit
import Parse

class FurnitureViewController: HomeViewController {
   override func fetchItems() {
       service.fetchItems (constraint: "Furniture"){ [weak self] (items) in
           DispatchQueue.main.async {
           self!.items = items
           self!.collectionView.reloadData()
           }
       }
   }
}


