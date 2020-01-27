//
//  SignUpViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 1/25/20.
//  Copyright © 2020 Rayan Ahmed. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    let backgroundImageView = UIImageView()
    @IBOutlet weak var tfFirstname: MyTextField!
    @IBOutlet weak var tfLastname: MyTextField!
    @IBOutlet weak var tfUsername: MyTextField!
    @IBOutlet weak var tfPassword: MyTextField!
    
    override func viewDidLoad() {
        setBackground()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setBackground () {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "bg2")
        view.sendSubviewToBack(backgroundImageView)
        
    }
    @IBAction func onSignUp(_ sender: Any) {
        let username = tfUsername.text!
        let password = tfPassword.text!
        let firstname = tfFirstname.text!
        let lastname = tfLastname.text!
        
        if (!isValidInput(text: username) ||
            !isValidInput(text: password) ||
            !isValidInput (text: firstname) ||
            !isValidInput (text: lastname)) {
            //todo better error handling
            displayErrorMessage()
        } else {
            
            let user = PFUser ()
            
            user.username = username
            user.password = password
            user["firsname"] = firstname
            user["lastname"] = lastname
            
            user.signUpInBackground { (successful, error) in
                if successful {
                    self.clearFields()
                    self.goToHomePage()
                } else {
                    //todo better error handling
                    self.displayErrorMessage()
                }
            }
        }
    }
    
    func clearFields () {
           tfUsername.text = ""
           tfPassword.text = ""
    }
    
    func isValidInput (text: String) -> Bool {
        if (text.isEmpty || text.count < 4) {
            return false;
        } else {
            return true;
        }
    }
    
    func displayErrorMessage () {
           let controller = UIAlertController (title: "Invalid inputs", message: "please provide valid inputs", preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
               self.dismiss (animated: true, completion: nil)
           }
           controller.addAction (okAction)
           present(controller, animated:true)
    }
    
    func goToHomePage () {
        let viewController = storyboard?.instantiateViewController(identifier: "TabBarController") as! TabBarController
        present(viewController, animated: true)
    }
}
