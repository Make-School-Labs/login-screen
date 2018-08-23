//
//  LoginViewController.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
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
        
    }
    
    @IBAction func unwindToLogin(_ segue: UIStoryboardSegue) {
        
    }

}
