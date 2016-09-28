//
//  TextFieldDelegate.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation
import UIKit

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        handleTap()
        
        return true
    }
}
