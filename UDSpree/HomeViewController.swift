//
//  FurnitureViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 1/26/20.
//  Copyright © 2020 Rayan Ahmed. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var items: [Item] = []
    let service = ItemService()
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchItems()
        
        if #available(iOS 10.0, *) {
                 collectionView.refreshControl = refreshControl
        } else {
                 collectionView.addSubview(refreshControl)
        }
             
        refreshControl.addTarget(self, action: #selector(refreshItemList(_:)), for: .valueChanged)
    }
    
    @objc private func refreshItemList(_ sender: Any) {
        fetchItems()
        self.refreshControl.endRefreshing()
    }
    
    func fetchItems() {
        service.fetchItems (constraint: ""){ [weak self] (items) in
            DispatchQueue.main.async {
            self!.items = items
            self!.collectionView.reloadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let selectedRow = items [indexPath.item]
        let detail = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
       detail.item = selectedRow
       
       navigationController?.pushViewController(detail, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellP", for: indexPath) as! ItemCellP
        cell.configure(item: items[indexPath.item])
        cell.layer.cornerRadius = 8.0
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
    

}
