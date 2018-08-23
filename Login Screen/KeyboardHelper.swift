//
//  KeyboardHelper.swift
//  Login Screen
//
//  Created by Erick Sanchez on 8/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation
import UIKit.UIWindow

protocol KeyboardHelperDelegate: class {
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didChangeKeyboardTo newPosition: CGFloat)
}

class KeyboardHelper: NSObject {
    
    unowned var delegate: KeyboardHelperDelegate
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        print("Keyboard will show: \(notification.name.rawValue)")
        
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            delegate.keyboardHelper(self, didChangeKeyboardTo: -keyboardRect.height + 64)
        } else {
            delegate.keyboardHelper(self, didChangeKeyboardTo: 0)
        }
    }
    
    init(delegate: KeyboardHelperDelegate) {
        self.delegate = delegate
        
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
}
