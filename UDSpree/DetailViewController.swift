//
//  DetailViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/17/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var ivItem: UIImageView!
    @IBOutlet weak var tvItemDescritption: UITextView!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
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
    
}
