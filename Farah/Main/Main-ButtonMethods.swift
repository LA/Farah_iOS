//
//  Main-ButtonMethods.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

private let timerInterval = 0.05 as Double
private let alphaRate = 0.01 as CGFloat

private let holdDownMsg = "Hold down to speak to Farah."
private let speakNowMsg = "Speak now. Release to stop recording."
private let transcribingMsg = "Transcribing..."

import Foundation
import UIKit

// MARK: Button Methods
extension MainViewController {
    
    func handleLongPress(from sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            talkButton.setImage(#imageLiteral(resourceName: "Recording Microphone"), for: .normal)
            textView.text = ""
            changeLabel(transcribing: false)
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
    
    func changeLabel(transcribing: Bool) {
        if (transcribing) {
            infoLabel.text = transcribingMsg
            return
        }

        if (infoLabel.text == holdDownMsg) {
            infoLabel.text = speakNowMsg
        } else if infoLabel.text == transcribingMsg {
            infoLabel.text = holdDownMsg
        }
    }
}
