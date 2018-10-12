//
//  DatePickerViewController.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/31/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate: class {
    func datePicker(_ datePickerViewController: DatePickerViewController, didFinishWith selectedDate: Date)
}

class DatePickerViewController: UIViewController {
    
    var delegate: DatePickerViewControllerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func pressDone(_ sender: Any) {
        delegate?.datePicker(self, didFinishWith: datePicker.date)
    }
    
    @IBAction func pressCancel(_ sender: Any) {
        
    }

}
