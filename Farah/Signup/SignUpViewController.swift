//
//  SignUpViewController.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import UIKit

private let labelSize = 20 as CGFloat
private let TFFontSize = 30 as CGFloat

// MARK: Properties & View Controller Methods
class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        setupViews()
        
        nameTextField.becomeFirstResponder()
        
        nameTextField.delegate = self
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: labelSize)
        label.frame.size.height = 15
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.font = UIFont.systemFont(ofSize: TFFontSize)
        textField.autocapitalizationType = .words
        textField.textColor = .lightGray
        textField.keyboardAppearance = .dark
        textField.returnKeyType = .continue
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(#imageLiteral(resourceName: "Signup"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
