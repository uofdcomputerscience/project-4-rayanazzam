//
//  Sell.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/17/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import UIKit
import Parse

class SellViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var ivUserImage: UIImageView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var animation: UIActivityIndicatorView!
    var types = ["Choose type", "Books", "Electronics", "Furntiure", "Other"]
    var locations = ["Choose location", "Clark Hall", "Theresa Hall", "Gregory Hall", "Tower Village", "Other"]
    private var selectedType = "Choose type"
    private var selectedLocation = "Choose location"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset=UIEdgeInsets(top:0.0, left: 0.0, bottom: 10.0, right: 0.0);
        pickerType.dataSource = self
        pickerType.delegate = self
        
        pickerLocation.dataSource = self
        pickerLocation.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        ivUserImage.isUserInteractionEnabled = true
        ivUserImage.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let vc = UIImagePickerController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pickerType: UIPickerView!
    @IBOutlet weak var pickerLocation: UIPickerView!
    
    @IBAction func onPost(_ sender: Any) {
        let title = tfTitle.text!
        let price = tfPrice.text!
        let description = tvDescription.text!
       
        if !validInputs (title: title, price: price, description: description) ||
            ivUserImage.image == nil ||
            selectedLocation == "Choose location" ||
            selectedType == "Choose type" {
           displayErrorMessage()
        } else {
            let item = Item ()
            item.setImage(image: ivUserImage.image!)
            item.setTitle(title: title)
            item.setPrice(price: price)
            item.setDescription(description: description)
            item.setType(type: selectedType)
            item.setLocation(location: selectedLocation)
            item.setUser(user: PFUser.current()!)
                  
           postItem(item: item)
        }
    }
    
    func validInputs (title: String, price: String, description: String) -> Bool {
        return !title.isEmpty && !price.isEmpty && Int(price) != nil
    }
    
    func postItem (item: Item){
        animation.startAnimating()
        
        let itemPost = PFObject (className: "Item")
        itemPost["title"] = item.itemTitle
        itemPost["price"] = item.itemPrice
        itemPost["description"] = item.itemDescription
        itemPost["user"] = item.itemUser
        itemPost["type"] = item.itemType
        itemPost["location"] = item.itemLocation
        
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
        selectedLocation = "Choose location"
        selectedType = "Choose type"
    }
    
    func displayErrorMessage () {
        let controller = UIAlertController (title: "Invalid inputs", message: "please provide valid inputs", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) 
        controller.addAction (okAction)
        present(controller, animated:true)
    }
    
    // Picker methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return self.types.count
        } else {
            return self.locations.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return self.types[row]
        } else {
            return self.locations[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1) {
            self.selectedType = self.types[row]
        } else {
            self.selectedLocation = self.locations[row]
        }
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

