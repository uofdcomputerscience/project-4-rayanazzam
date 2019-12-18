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
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tvItemsList: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tvItemsList.delegate = self
        tvItemsList.dataSource = self
        fetchItems()
        
        if #available(iOS 10.0, *) {
            tvItemsList.refreshControl = refreshControl
        } else {
            tvItemsList.addSubview(refreshControl)
        }
        
         refreshControl.addTarget(self, action: #selector(refreshItemList(_:)), for: .valueChanged)
    }
    
    @objc private func refreshItemList(_ sender: Any) {
        fetchItems()
        self.refreshControl.endRefreshing()
    }
    
    func fetchItems() {
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


