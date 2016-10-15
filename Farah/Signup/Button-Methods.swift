//
//  Button-Methods.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation
import UIKit

extension SignUpViewController {
    
    // Called when signup is pressed
    func signUpTapped() {
    
        // Create Farah MainVC
        let vc = MainViewController()
        
        // If user entered a name, make that the name
        // else just make it 'You'        
        var name = nameTextField.text!
        if name == "" { name = "You" }

        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(true, forKey: "isSaved")

        vc.name = name
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Called when a gender is selected
    func genderSelected(sender: UIButton) {
        switch sender {
        case femaleButton:
            femaleButton.isSelected = true
            maleButton.isSelected = false
        case maleButton:
            maleButton.isSelected = true
            femaleButton.isSelected = false
        default:
            maleButton.isSelected = false
            femaleButton.isSelected = false
        }
    }
}
