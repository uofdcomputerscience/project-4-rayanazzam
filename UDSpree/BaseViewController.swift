//
//  BaseViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 1/25/20.
//  Copyright © 2020 Rayan Ahmed. All rights reserved.
//

import UIKit
import CarbonKit

class BaseViewController: UIViewController, CarbonTabSwipeNavigationDelegate {
    override func viewDidAppear(_ animated: Bool) {
       let items = ["All", "Books", "Electronics", "Furniture", "Other"]
       let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
       carbonTabSwipeNavigation.setTabExtraWidth(20)
       carbonTabSwipeNavigation.insert(intoRootViewController: self)
    }
    override func viewDidLoad() {
        print("hello")
    }
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        let home = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        if (index == 0) {
            return home
        } else if (index == 1) {
           object_setClass(home, BooksViewController.self)
           let subclassObject = home as! BooksViewController
           return subclassObject
            
        } else if (index == 2) {
            object_setClass(home, ElectronicsViewController.self)
            let subclassObject = home as! ElectronicsViewController
            return subclassObject
        } else if (index == 3) {
            object_setClass(home, FurnitureViewController.self)
            let subclassObject = home as! FurnitureViewController
            return subclassObject
        } else {
            object_setClass(home, OtherViewController.self)
            let subclassObject = home as! OtherViewController
            return subclassObject
        }
    }
    @IBAction func onProfileClick(_ sender: Any) {
        let profile = storyboard?.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        navigationController?.pushViewController(profile, animated: true)
    }
}
