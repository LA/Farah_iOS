//
//  Layout.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation
import UIKit

// MARK: Layout Views
extension MainViewController {
    
    func setupViews() {
        // Add all properties to main view.
        view.addSubview(talkButton)
        view.addSubview(textView)
        view.addSubview(infoLabel)
        
        // Change background color to global background color.
        view.backgroundColor = homeBGColor
        
        // Center properties horizontally.
        view.addConstraint(NSLayoutConstraint(item: talkButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        // Set VFL constraints.
        view.addConstraints(withFormat: "H:|-25-[v0]-25-|", views: textView)
        view.addConstraints(withFormat: "H:|-25-[v0]-25-|", views: infoLabel)
        view.addConstraints(withFormat: "V:|-45-[v0]-30-[v2]-15-[v1]-25-|", views: textView, talkButton, infoLabel)
    }
    
    // Change the UI with response.
    func UIrespond(with message: String) {
        
        // Affect text
        textView.insertText("\n\n")
        textView.insertText("Farah: ")
        textView.insertText(message)
    }
    
    // Change Button UI
    func UIchangeButton(recording: Bool) {
        if recording {
            // Adjust UI for recording and start a timer to pulse the button.
            talkButton.setImage(#imageLiteral(resourceName: "Recording Microphone"), for: .normal)
            textView.text = ""
            changeLabel(transcribing: false)
            timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(pulseButton), userInfo: nil, repeats: true)
            recordSpeech()
        } else {
            talkButton.setImage(#imageLiteral(resourceName: "Microphone"), for: .normal)
            talkButton.alpha = 1
            timer.invalidate()
            finishRecording(success: true)
        }
    }
    
    // Change Label UI
    // Change info label based on whether or not we're transcribing
    func changeLabel(transcribing: Bool) {
        
        // If we are transcribing
        if (transcribing) {
            
            // Start a repeating timer that calls animateLabel after Time Interval
            transcribingTimer = Timer.scheduledTimer(timeInterval: timerInterval * 7.5, target: self, selector: #selector(animateLabel), userInfo: nil, repeats: true)
            
            // Leave method
            return
        }
        
        // Not transcribing
        // End the timer
        transcribingTimer.invalidate()
        
        // Adjust label
        if (infoLabel.text == holdDownMsg) {
            infoLabel.text = speakNowMsg
        } else {
            infoLabel.text = holdDownMsg
        }
    }
}
