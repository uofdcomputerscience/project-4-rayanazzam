//
//  ProfileViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/18/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tfFirstname: UITextField!
    @IBOutlet weak var tfLastname: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    let currUser = PFUser.current()
    
    @IBAction func onSave(_ sender: Any) {
      let firstname = tfFirstname.text!
      let lastname = tfLastname.text!
      let email = tfEmail.text!
      let phonenumber = tfPhoneNumber.text!
      
      if (firstname.isEmpty || lastname.isEmpty || email.isEmpty) {
          displayErrorMessage()
      } else {
          updateUser (firstname: firstname, lastname: lastname, email: email, phonenumber: phonenumber)
      }
    }
    @IBAction func onLogOut(_ sender: Any) {
        print("loggin out")
        PFUser.logOut()
        let viewController = storyboard?.instantiateViewController(identifier: "LogInViewController") as! LogInViewController
       self.dismiss(animated: true)
       present(viewController, animated: true)
    }
    
    
    func displayErrorMessage () {
        let controller = UIAlertController (title: "Invalid inputs", message: "please provide valid inputs", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.dismiss (animated: true, completion: nil)
        }
        controller.addAction (okAction)
        present(controller, animated:true)
    }
    
    func updateUser (firstname: String, lastname: String, email: String, phonenumber: String) {
        currUser!["firstname"] = firstname
        currUser!["lastname"] = lastname
        currUser!["email"] = email
        currUser!["phone"] = phonenumber
        
        currUser?.saveInBackground(block: { (success, error) in
            if success {
                print("successfully updated user")
                let controller = UIAlertController(title: "Success!", message: "Your information has been saved!", preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                    controller.dismiss(animated: true, completion: nil)
                }
                controller.addAction(okAction)
                self.present(controller, animated: true)
                
                
                self.clearFields()
                
            }
        })
    }
    
    func clearFields() {
        self.tfPhoneNumber.text = ""
        self.tfEmail.text = ""
        self.tfFirstname.text = ""
        self.tfLastname.text = ""
    }
}
