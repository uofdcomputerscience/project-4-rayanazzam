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
    
    let backgroundImageView = UIImageView()
    
    var user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PFUser.current() != nil {
            goToHomePage()
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setBackground()
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
                self.clearFields()
               self.goToHomePage()
             } else {
                //todo better error handling
                self.displayErrorMessage()
             }
           }
       }
    }
    @IBAction func onSignUp(_ sender: Any) {
        
        let signUp = storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(signUp, animated: true)
        
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
    
    func clearFields () {
        tfUsername.text = ""
        tfPassword.text = ""
    }
}

