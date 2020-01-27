//
//  BooksViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 1/26/20.
//  Copyright © 2020 Rayan Ahmed. All rights reserved.
//

import UIKit

class BooksViewController: HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func fetchItems() {
        service.fetchItems (constraint: "Books"){ [weak self] (items) in
            DispatchQueue.main.async {
            self!.items = items
            self!.collectionView.reloadData()
            }
        }
    }
}
