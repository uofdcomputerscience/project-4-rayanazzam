//
//  Sell.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/17/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import UIKit
import Parse

class SellViewController: UIViewController {
    
    @IBOutlet weak var tfTitle: UITextField!
    
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var ivUserImage: UIImageView!
    @IBOutlet weak var tvDescription: UITextView!
    
    @IBOutlet weak var animation: UIActivityIndicatorView!
    @IBAction func onPictureSelect(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    @IBAction func onPost(_ sender: Any) {
        let title = tfTitle.text!
        let price = tfPrice.text!
        let description = tvDescription.text!
        
        if !validInputs (title: title, price: price, description: description) || ivUserImage.image == nil {
            // show alert
            return
        }
        
        let item = Item ()
        item.setImage(image: ivUserImage.image!)
        item.setTitle(title: title)
        item.setPrice(price: price)
        item.setDescription(description: description)
        item.setUser(user: PFUser.current()!)
        
        postItem(item: item)
        
    }
    
    func validInputs (title: String, price: String, description: String) -> Bool {
        return true
    }
    
    func postItem (item: Item){
        animation.startAnimating()
        
        let itemPost = PFObject (className: "Item")
        itemPost["title"] = item.itemTitle
        itemPost["price"] = item.itemPrice
        itemPost["description"] = item.itemDescription
        itemPost["user"] = item.itemUser
        
        //let imageData = item.itemImage!.pngData()!
        let imageData = item.itemImage!.jpeg(.lowest)
        let imageFile = PFFileObject(name:"image.png", data:imageData!)
        itemPost["image"] = imageFile
        
        itemPost.saveInBackground { (succeeded, error) in
            if succeeded {
                //alert user that post has been created successfully
                print("post created successfully")
                let controller = UIAlertController(title: "Success!", message: "Your Item has been posted successfully!", preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                    controller.dismiss(animated: true, completion: nil)
                }
                controller.addAction(okAction)
                self.present(controller, animated: true)
                
                
                self.clearFields()
            } else {
                print("failed to create post")
            }
        }
        
        animation.stopAnimating()
    }
    
    func clearFields () {
        tfPrice.text = ""
        tfTitle.text = ""
        tvDescription.text = "Description ..."
        ivUserImage.image = nil
    }
}


extension SellViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        ivUserImage.image = image
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

extension SellViewController: UINavigationControllerDelegate {

}

// parse server has a 20mb limit for file objects.
// This extension servers to  handle that
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

