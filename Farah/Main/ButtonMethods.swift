//
//  ButtonMethods.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

private let timerInterval = 0.05 as Double
private let alphaRate = 0.01 as CGFloat

import Foundation
import UIKit

// MARK: Button Methods
extension MainViewController {
    
    func handleTap(recording: Bool) {
        if talkButton.imageView!.image == #imageLiteral(resourceName: "Microphone") {
            handleButton(recording: true)
        } else if talkButton.imageView!.image == #imageLiteral(resourceName: "Recording Microphone") {
            handleButton(recording: false)
        }
    }
    
    func handleLongPress(from sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            handleButton(recording: true)
        } else if sender.state == .ended {
            handleButton(recording: false)
        }
    }
    
    func handleButton(recording: Bool) {
        
        if transcribing { return }
        
        if recording {
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
