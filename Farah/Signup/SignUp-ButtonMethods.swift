//
//  SignUp-ButtonMethods.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation
import UIKit

extension SignUpViewController {
    
    func handleTap() {
        
        let vc = MainViewController()
        if let name = nameTextField.text {
            if name == "" {
                vc.name = "You"
            } else {
                vc.name = name
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
