//
//  DatePickerViewController.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate: class {
    func datePicker(_ datePickerViewController: DatePickerViewController, didFinishWith selecteDate: Date)
}

class DatePickerViewController: UIViewController {

    weak var delegate: DatePickerViewControllerDelegate?
    
    var minDate: Date?
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
        delegate?.datePicker(self, didFinishWith: datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = header
        labelSubheading.text = subheader
        
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        
        viewContainer.layer.cornerRadius = 8.0
    }
    
}
