//
//  Layout-.swift
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
        
        // Set title
        title = "Sign Up"
        
        // Add Properties to View
        view.addSubview(nameTextField)
        view.addSubview(signupButton)
        view.addSubview(nameLabel)
        view.addSubview(maleButton)
        view.addSubview(femaleButton)
        
        view.backgroundColor = homeBGColor
        
        layoutNSConstraints()
        layoutVFL()
    }
    
    func layoutNSConstraints() {
        // Center Everything Horizontally
        centerH(nameLabel, in: view)
        centerH(nameTextField, in: view)
        centerH(signupButton, in: view)
        
        // Set Text Field to 60% the width of the View
        view.addConstraint(NSLayoutConstraint(item: nameTextField, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.60, constant: 1))
    }
    
    func centerH(_ object: AnyObject, in view: UIView) {
        // Create Constraint
        let centerContstraint = NSLayoutConstraint(item: object, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        // Add to view
        view.addConstraint(centerContstraint)
    }
    
    func layoutVFL() {
        // Layout Views with Visual Format
        // Vertical
        view.addConstraints(withFormat: "V:|-75-[v0]-5-[v1]-25-[v2]", views: nameLabel, nameTextField, maleButton)
        view.addConstraints(withFormat: "V:|-75-[v0]-5-[v1]-25-[v2]", views: nameLabel, nameTextField, femaleButton)
        view.addConstraints(withFormat: "V:[v0]-50-|", views: signupButton)
        
        // Horizontal
        view.addConstraints(withFormat: "H:|-\((UIScreen.main.bounds.size.width / 3)-10)-[v0]", views: maleButton)
        view.addConstraints(withFormat: "H:[v0]-5-[v1]-\((UIScreen.main.bounds.size.width / 3)-10)-|", views: maleButton, femaleButton)
    }
}
