//
//  Main-ButtonMethods.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

private let timerInterval = 0.05 as Double
private let alphaRate = 0.009 as CGFloat

import Foundation
import UIKit

// MARK: Button Methods
extension MainViewController {
    
    func handleLongPress(from sender: UILongPressGestureRecognizer) {
        print("Long Press Activated")
        if sender.state == .began {
            talkButton.setImage(#imageLiteral(resourceName: "Recording Microphone"), for: .normal)
            textView.text = ""
            timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(pulseButton), userInfo: nil, repeats: true)
            recordSpeech()
        } else if sender.state == .ended {
            print("Ended")
            talkButton.setImage(#imageLiteral(resourceName: "Microphone"), for: .normal)
            talkButton.alpha = 1
            talkButton.isSelected = false
            timer.invalidate()
            finishRecording(success: true)
        }
    }
    
    func pulseButton() {
        if increaseAlpha {
            talkButton.alpha += alphaRate
        } else {
            talkButton.alpha -= alphaRate
        }
        
        if talkButton.alpha >= 1 {
            increaseAlpha = false
        } else if talkButton.alpha <= 0.4 {
            increaseAlpha = true
        }
    }
}
