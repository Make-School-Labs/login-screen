//
//  LoginViewController.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    func loginUser(username: String, password: String) {
        //TODO: login user
    }
    
    @IBOutlet weak var textFieldUsername: ValidationTextField! {
        didSet {
            textFieldUsername.resultValidations = [
                ValidationTextField.Validations.length(rangingFrom: 6, to: 20)
            ]
        }
    }
    
    @IBOutlet weak var textFieldPassword: ValidationTextField! {
        didSet {
            textFieldPassword.resultValidations = [
                ValidationTextField.Validations.length(rangingFrom: 6, to: 20)
            ]
        }
    }
    
    @IBAction func pressLogin(_ sender: Any) {
        guard
            textFieldUsername.textFieldHasValidInput,
            textFieldPassword.textFieldHasValidInput else {
                return
        }
        
        guard
            let username = textFieldUsername.text,
            let password = textFieldPassword.text else {
                return
        }
        
        loginUser(username: username, password: password)
    }
    
    @IBAction func unwindToLogin(_ segue: UIStoryboardSegue) {
        
    }

}
