//
//  OtherViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 1/26/20.
//  Copyright © 2020 Rayan Ahmed. All rights reserved.
//

import UIKit

class OtherViewController: HomeViewController {
    override func fetchItems() {
        service.fetchItems (constraint: "Other"){ [weak self] (items) in
            DispatchQueue.main.async {
            self!.items = items
            self!.collectionView.reloadData()
            }
        }
    }
}
