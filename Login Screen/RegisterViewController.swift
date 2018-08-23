//
//  RegisterViewController.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    lazy var keyboardHelper = KeyboardHelper(delegate: self)
    
    var selectedBirthday: Date?
    
    func registerNewUser(firstName: String, lastName: String, birthday: Date, password: String) {
        //TODO: register the user here
    }
    
    @IBAction func tapToDismissKeyboard(_ sender: Any) {
        view.endEditing(false)
    }
    
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
    @IBAction func pressBirthday(_ sender: Any) {
        let datePickerVc = DatePickerViewController.newViewController(
            header: "Birthday",
            subheader: "select your birthday"
        )
        datePickerVc.delegate = self
        
        let now = Date()
        datePickerVc.maxDate = now
        
        if let selectedDate = self.selectedBirthday {
            datePickerVc.selectedDate = selectedDate
        }
        
        present(datePickerVc, animated: true)
    }
    
    @IBOutlet weak var textFieldPassword: ValidationTextField! {
        didSet {
            textFieldPassword.resultValidations = [
                ValidationTextField.Validations.length(rangingFrom: 6, to: 20)
            ]
        }
    }
    
    @IBOutlet weak var textFieldPasswordConfirm: ValidationTextField!
    
    @IBAction func pressRegister(_ sender: Any) {
        
        guard
            textFieldFirstName.textFieldHasValidInput,
            textFieldLastName.textFieldHasValidInput,
            textFieldUsername.textFieldHasValidInput,
            let birthday = self.selectedBirthday,
            textFieldPassword.textFieldHasValidInput,
            textFieldPasswordConfirm.textFieldHasValidInput else {
                let missingInputAlert = UIAlertController(
                    title: "Registering", message: "please fill all required fields",
                    preferredStyle: .alert
                )
                
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
                missingInputAlert.addAction(dismissAction)
                
                present(missingInputAlert, animated: true)
                return
        }
        
        guard
            let firstName = textFieldFirstName.text,
            let lastName = textFieldLastName.text,
            let password = textFieldPassword.text else {
                return
        }
        
        registerNewUser(firstName: firstName, lastName: lastName, birthday: birthday, password: password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldPasswordConfirm.resultValidations = [
            ValidationTextField.Validations.length(rangingFrom: 6, to: 20),
            ValidationTextField.Validations.equal(to: textFieldPassword)
        ]
        
        _ = keyboardHelper
    }
}

extension RegisterViewController: KeyboardHelperDelegate {
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didChangeKeyboardTo newPosition: CGFloat) {
        view.frame.origin.y = newPosition
    }
}

extension RegisterViewController: DatePickerViewControllerDelegate {
    func datePicker(_ datePickerViewController: DatePickerViewController, didFinishWith selecteDate: Date) {
        selectedBirthday = selecteDate
        
        let birthdayString = selecteDate.stringValue
        buttonBirthdate.setTitle(birthdayString, for: .normal)
        
        dismiss(animated: true)
    }
    
    func datePicker(
        _ datePickerViewController: DatePickerViewController,
        canSelect date: Date
        ) -> (success: Bool, message: String) {
        let secondsSinceSelectedDate = Date().timeIntervalSince(date)
        let seconds18YearsAgo: TimeInterval = 60 * 60 * 24 * 356 * 18
        
        if secondsSinceSelectedDate >= seconds18YearsAgo {
            return (true, "")
        } else {
            return (false, "you cannot register being yonger than 18 years of age")
        }
    }
}
