//
//  HomeViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/15/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {
    var items: [Item] = []
    let service = ItemService()
    
    @IBOutlet weak var tvItemsList: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let weapons = ["Ray", "baba"]

        // wishlist logic
        /*
        let user = PFUser.current()
        user!["wishlist"] = weapons
        user?.saveInBackground()
         */

        tvItemsList.delegate = self
        tvItemsList.dataSource = self
        
        service.fetchItems { [weak self] (items) in
            DispatchQueue.main.async {
            self!.items = items
            self!.tvItemsList.reloadData()
            }
        }
        
    }

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.configure(item: items[indexPath.item], tvItems: self.tvItemsList)
        return cell
    }
}
