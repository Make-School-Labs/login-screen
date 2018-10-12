//
//  RegisterViewController.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/31/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "show date picker":
                guard let datePickerViewController = segue.destination as? DatePickerViewController else {
                    return print("storyboard not set up correctly")
                }
                
                datePickerViewController.delegate = self
            default: break
            }
        }
    }
}
