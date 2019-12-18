//
//  WishListViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/18/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import Foundation
import UIKit
import Parse

class WishListViewController: UIViewController {
    var items: [Item] = []
    let service = ItemService()
    var wishlist : [AnyObject] = []
    let currUser = PFUser.current()
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tvWhishList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvWhishList.delegate = self
        tvWhishList.dataSource = self
        
        if #available(iOS 10.0, *) {
            tvWhishList.refreshControl = refreshControl
        } else {
            tvWhishList.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshWishList(_:)), for: .valueChanged)
        
        DispatchQueue.main.async {
            self.fetchWishList()
            self.getItems()
            self.tvWhishList.reloadData()
        }
        
    }
    
    @objc private func refreshWishList(_ sender: Any) {
        DispatchQueue.main.async {
            self.fetchWishList()
            self.getItems()
            self.tvWhishList.reloadData()
        }
        
        self.refreshControl.endRefreshing()
    }
    
    func fetchWishList() {
        do {
            try currUser?.fetchIfNeeded()
            if let wlist = currUser!["wishlist"] as? [AnyObject] {
                wishlist = wlist
            }
        } catch {
            print("error trying to fetch wishlist of current user")
        }
    }
    
    func getItems () {
        self.items = []
        for object in wishlist {
            do {
                let object = try object.fetchIfNeeded()
                let item = Item()
                item.setTitle(title: object["title"] as! String)
                item.setPrice (price: object["price"] as! String)
                item.setDescription(description: object["description"] as! String)
                item.setUser (user: object["user"] as! PFUser)
                item.setId(id: object.objectId!)
                                          
                //attaching image
                let itemImageFile = object["image"] as! PFFileObject
                itemImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                                                   
                    } else if let imageData = imageData {
                        item.setImage(image: UIImage(data:imageData)!)
                    }
                }
                items.append(item)
            } catch {
                print("error trying to fetch wishlist of current user")
            }
            
        }
    }
    
    
        
}

extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.configure(item: items[indexPath.item])
        return cell
    }
    
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedRow = items [indexPath.item]
        let detail = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detail.item = selectedRow
        navigationController?.pushViewController(detail, animated: true)
    }
    
}
