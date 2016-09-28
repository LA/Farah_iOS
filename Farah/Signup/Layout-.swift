//
//  Layout.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

private let heightMultiplier = 0.15 as CGFloat

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
        
        // Make TextField Size a Fraction of the Button.
        view.addConstraint(NSLayoutConstraint(item: nameTextField, attribute: .height, relatedBy: .equal, toItem: signupButton, attribute: .height, multiplier: heightMultiplier, constant: 1.0))
        
        // Layout Views with Visual Format
        view.addConstraints(withFormat: "V:|-75-[v2]-5-[v0]-300-[v1]|", views: nameTextField, signupButton, nameLabel)
        view.addConstraints(withFormat: "H:|-75-[v0]-75-|", views: nameTextField)
        view.addConstraints(withFormat: "H:|-75-[v0]|", views: nameLabel)
    }
}
