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
    func handleTap() {
        
        // Create Farah MainVC
        let vc = MainViewController()
        
        // If user entered a name, make that the name
        // else just make it 'You'
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
