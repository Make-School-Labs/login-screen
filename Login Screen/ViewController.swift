//
//  ViewController.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func loginUser(username: String, password: String) {
        
        //TODO: login user
        
        print("Welcome, \(username)!")
    }
    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBAction func pressLogin(_ sender: Any) {
        
        guard
            textFieldUsername.text?.isEmpty == false,
            let username = textFieldUsername.text,
            textFieldPassword.text?.isEmpty == false,
            let password = textFieldPassword.text else {
                return print("text fields must not be empty!")
        }
        
        //dismiss keyboard
        view.endEditing(false)
        
        loginUser(username: username, password: password)
    }
    
    @IBAction func pressSignUp(_ sender: Any) {
        performSegue(withIdentifier: "show register", sender: nil)
    }
}

