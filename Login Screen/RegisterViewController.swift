//
//  RegisterViewController.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var textFieldFirstName: ValidationTextField! {
        didSet {
            textFieldFirstName.resultValidations = [
                ValidationTextField.Validations.cannotBeEmpty
            ]
        }
    }
    
    @IBOutlet weak var textFieldLastName: ValidationTextField! {
        didSet {
            textFieldLastName.resultValidations = [
                ValidationTextField.Validations.cannotBeEmpty
            ]
        }
    }
    
    @IBOutlet weak var textFieldUsername: ValidationTextField! {
        didSet {
            textFieldUsername.resultValidations = [
                ValidationTextField.Validations.length(rangingFrom: 6, to: 20)
            ]
        }
    }
    
    @IBOutlet weak var buttonBirthdate: UIButton!
    @IBOutlet weak var textFieldPassword:  ValidationTextField! {
        didSet {
            textFieldPassword.resultValidations = [
                ValidationTextField.Validations.length(rangingFrom: 6, to: 20)
            ]
        }
    }
    
    @IBOutlet weak var textFieldPasswordConfirm:  ValidationTextField!
    
    @IBAction func pressRegister(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldPasswordConfirm.resultValidations = [
            ValidationTextField.Validations.length(rangingFrom: 6, to: 20),
            ValidationTextField.Validations.equal(to: textFieldPassword)
        ]
    }
}
