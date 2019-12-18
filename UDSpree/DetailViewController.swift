//
//  DetailViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/17/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import Foundation
import UIKit
import Parse

class DetailViewController: UIViewController {
    @IBOutlet weak var ivItem: UIImageView!
    @IBOutlet weak var tvItemDescritption: UITextView!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    var wishlist: [AnyObject] = []
    let currUser = PFUser.current()
    
    var item: Item?
    
    override func viewDidLoad() {
        ivItem.image = item?.itemImage
        tvItemDescritption.text = item?.itemDescription
        
        do {
            try item!.itemUser?.fetchIfNeeded()
            lblusername.text = "Username: " + String (item?.itemUser?["username"] as? String ?? "no username")
            lblEmail.text = "Email: " + String(item?.itemUser?["email"] as? String ?? "no email")
        } catch {
            print("error trying to fetch username and email from PFUser")
        }
        
        
        
        
        
    }
    @IBAction func onAddToWishList(_ sender: Any) {
        fetchWishList()
        let query = PFQuery(className: "Item")
        query.getObjectInBackground(withId: item!.itemId!) {(object, error) in
            self.wishlist.append(object!)
            
            self.currUser!["wishlist"] = self.wishlist
            self.currUser?.saveInBackground(){ (success, error) in
                if success {
                    print("successfully updated user")
                }else {
                 print("could not update user")
                }
            }
        }
        
        
            
        let controller = UIAlertController(title: "Success!", message: "Added to wishlist!", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            let viewController = self.storyboard?.instantiateViewController(identifier: "TabBarController") as! TabBarController
            self.present(viewController, animated: true)
        }
        controller.addAction(okAction)
        self.present(controller, animated: true)
        
        
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
    
    
    
}
