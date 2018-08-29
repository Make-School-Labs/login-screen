//
//  ValidationTextField.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ValidationTextField: UITextField {
    
    typealias StringValidation = (String) -> Bool
    
    enum Validations {
        static var cannotBeEmpty: StringValidation = { textValue in
            return textValue.isEmpty == false
        }
        
        static var all: StringValidation = { textValue in
            return true
        }
        
        static var nonNumbers: StringValidation = { textValue in
            return Int(textValue) == nil
        }
        
        static var numbersOnly: StringValidation = { textValue in
            return Int(textValue) != nil
        }
        
        static func length(greaterThan length: Int) -> StringValidation {
            let validation: StringValidation = { textValue in
                return textValue.count > length
            }
            
            return validation
        }
        
        static func length(rangingFrom min: Int, to max: Int) -> StringValidation {
            let validation: StringValidation = { textValue in
                return textValue.count >= min && textValue.count <= max
            }
            
            return validation
        }
        
        static func equal(to textField: UITextField) -> StringValidation {
            let validation: StringValidation = { [weak weakTextField = textField] textValue in
                return textValue == weakTextField?.text ?? ""
            }
            
            return validation
        }
    }

    /** asks is the text, at the end of the editing, valid or show invalid colors */
    var inputValidation: StringValidation?
    
    /** asks is the inserted or deleted string valid, if not undo */
    var resultValidations: [StringValidation]?
    
    var allowsResignFirstResponderOnReturn = true
    
    var textFieldHasValidInput: Bool {
        set {
            if newValue {
                hideInvalidColors()
            } else {
                showInvalidColors()
            }
        }
        get {
            return layer.borderWidth == 0
        }
    }
    
    @IBOutlet weak var nextResponderToBecomeResponder: UIResponder?
    
    @IBOutlet weak var textFieldValidationDelegate: UITextFieldDelegate? {
        didSet {
            delegate = self
        }
    }
    
    /**
     tests the given string and mutates the text field if validation fails
     
     - warning: `self.resultValidation` is tested here
     
     - returns: if validation failed or succeeded
     */
    func setValidateResult(with string: String) {
        var validationPassed = true
        
        if let validations = resultValidations {
            for aValidation in validations {
                if aValidation(string) == false {
                    validationPassed = false
                    break
                }
            }
        }
        
        if validationPassed {
            hideInvalidColors()
        } else {
            showInvalidColors()
        }
    }
    
    private func showInvalidColors() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
    }
    
    private func hideInvalidColors() {
        layer.borderColor = nil
        layer.borderWidth = 0
    }
    
}

extension ValidationTextField: UITextFieldDelegate {
    
    // MARK: - RETURN VALUES
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if allowsResignFirstResponderOnReturn {
            if let nextResponder = nextResponderToBecomeResponder {
                if nextResponder.canBecomeFirstResponder {
                    nextResponder.becomeFirstResponder()
                } else if let control = nextResponder as? UIControl {
                    textField.resignFirstResponder()
                    control.sendActions(for: .touchUpInside)
                }
            } else {
                textField.resignFirstResponder()
            }
            return false
        } else {
            return textFieldValidationDelegate?.textFieldShouldReturn?(textField) ?? true
        }
    }
    
    // MARK: - VOID METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return textFieldValidationDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldValidationDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        return inputValidation?(string) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setValidateResult(with: textField.text ?? "")
        
        textFieldValidationDelegate?.textFieldDidEndEditing?(textField)
    }
}
