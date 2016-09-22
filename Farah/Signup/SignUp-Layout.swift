//
//  SignUp-Layout.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation
import UIKit

// MARK: Layout Views
extension SignUpViewController {
    
    func setupViews() {
        
        // Add Properties to View
        view.addSubview(nameTextField)
        view.addSubview(signupButton)
        view.addSubview(nameLabel)
        
        // Center Everything Horizontally
        view.addConstraint(NSLayoutConstraint(item: nameTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: signupButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        // Make TextField half the size of the Button.
        view.addConstraint(NSLayoutConstraint(item: nameTextField, attribute: .height, relatedBy: .equal, toItem: signupButton, attribute: .height, multiplier: 0.5, constant: 1.0))
        
        // Layout Views with Visual Format
        view.addConstraints(withFormat: "V:|-75-[v2]-5-[v0]-250-[v1]-45-|", views: nameTextField, signupButton, nameLabel)
        view.addConstraints(withFormat: "H:|-25-[v0]-25-|", views: nameTextField)
        view.addConstraints(withFormat: "H:|-25-[v0]|", views: nameLabel)
    }
}
