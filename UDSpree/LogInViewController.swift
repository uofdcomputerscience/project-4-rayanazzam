//
//  ViewController.swift
//  UDSpree
//
//  Created by Rayan Ahmed on 12/15/19.
//  Copyright © 2019 Rayan Ahmed. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin(_ sender: Any) {
       let username = tfUsername.text!
       let password = tfPassword.text!
       if (!isValidInput(text: username) || !isValidInput(text: password)) {
         //todo better error handling
           displayErrorMessage()
       } else {
           PFUser.logInWithUsername(inBackground: username, password:password) {
             (user, error) -> Void in
             if user != nil {
               self.goToHomePage()
             } else {
                //todo better error handling
                self.displayErrorMessage()
             }
           }
       }
    }
    @IBAction func onSignUp(_ sender: Any) {
        let username = tfUsername.text!
        let password = tfPassword.text!
        
        if (!isValidInput(text: username) || !isValidInput(text: password)) {
            //todo better error handling
            displayErrorMessage()
        } else {
            
            user.username = username
            user.password = password
            
            user.signUpInBackground { (successful, error) in
                if successful {
                    self.goToHomePage()
                } else {
                    //todo better error handling
                    self.displayErrorMessage()
                }
            }
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
    
    func isValidInput (text: String) -> Bool {
        if (text.isEmpty || text.count < 4) {
            return false;
        } else {
            return true;
        }
    }
    
    func goToHomePage () {
        let viewController = storyboard?.instantiateViewController(identifier: "TabBarController") as! TabBarController
        present(viewController, animated: true)
    }
}

