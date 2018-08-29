//
//  DatePickerViewController.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate: class {
    func datePicker(
        _ datePickerViewController: DatePickerViewController,
        didFinishWith selecteDate: Date
    )
    
    func datePicker(
        _ datePickerViewController: DatePickerViewController,
        canSelect
        date: Date
        ) -> (success: Bool, message: String)
    
    func datePickerDidCancel(
        _ datePickerViewController: DatePickerViewController)
}

class DatePickerViewController: UIViewController {

    weak var delegate: DatePickerViewControllerDelegate?
    
    var minDate: Date?
    var selectedDate: Date = Date()
    var maxDate: Date?
    
    private(set) var header: String = "Date Picker"
    private(set) var subheader: String = "pick a date"
    
    static func newViewController(header: String, subheader: String) -> DatePickerViewController {
        let storyboard = UIStoryboard(name: "DatePickerViewController", bundle: nil)
        guard
            let viewController = storyboard.instantiateInitialViewController(),
            let datePickerVc = viewController as? DatePickerViewController else {
                fatalError("storyboard not set up correctly")
        }
        
        datePickerVc.header = header
        datePickerVc.subheader = subheader
        
        datePickerVc.modalTransitionStyle = .crossDissolve
        datePickerVc.modalPresentationStyle = .overFullScreen
        
        return datePickerVc
    }
    
    @IBOutlet private weak var viewContainer: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubheading: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func changedDatePicker(_ sender: Any) {
        
    }
    
    @IBAction func pressDone(_ sender: Any) {
        guard let delegate = self.delegate else { return }
        
        let validSelectedDate = delegate.datePicker(self, canSelect: datePicker.date)
        if validSelectedDate.success {
            delegate.datePicker(self, didFinishWith: datePicker.date)
        } else {
            let dateInvalidAlert = UIAlertController(
                title: self.header,
                message: validSelectedDate.message,
                preferredStyle: .alert
            )
            
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
            dateInvalidAlert.addAction(dismissAction)
            
            present(dateInvalidAlert, animated: true)
        }
    }
    
    @IBAction func pressCancel(_ sender: Any) {
        guard let delegate = self.delegate else { return }
        
        delegate.datePickerDidCancel(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = header
        labelSubheading.text = subheader
        
        datePicker.minimumDate = minDate
        datePicker.date = selectedDate
        datePicker.maximumDate = maxDate
        
        viewContainer.layer.cornerRadius = 8.0
    }
    
}
