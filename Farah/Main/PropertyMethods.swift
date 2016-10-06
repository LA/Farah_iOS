//
//  PropertyMethods.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation
import UIKit

// MARK: Button Methods
extension MainViewController {
    
    // If user taps the recording button, check what state the
    // button is in and flip it
    func handleTap(recording: Bool) {
        if talkButton.imageView!.image == #imageLiteral(resourceName: "Microphone") {
            handleButton(recording: true)
        } else if talkButton.imageView!.image == #imageLiteral(resourceName: "Recording Microphone") {
            handleButton(recording: false)
        }
    }
    
    // If user holds the recording button, call handleButton(true),
    // and call handleButton(false) when released
    func handleLongPress(from sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            handleButton(recording: true)
        } else if sender.state == .ended {
            handleButton(recording: false)
        }
    }
    
    // Called by both handleTap and handleLongPress
    func handleButton(recording: Bool) {
        
        // If we're transcribing, don't let user mess it up
        if transcribing { return }
        
        // Change button UI based on recording
        UIchangeButton(recording: recording)

    }
}
