//
//  Animations.swift
//  Farah
//
//  Created by Adar Butel on 9/29/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import UIKit

private let alphaRate = 0.01 as CGFloat

extension MainViewController {
    
    // Make button change transparency over time
    func pulseButton() {
        
        // Increase or decrease alpha based on controller property
        if increaseAlpha {
            talkButton.alpha += alphaRate
        } else {
            talkButton.alpha -= alphaRate
        }
        
        // If alpha is 1 or greater, start lowering alpha
        if talkButton.alpha >= 1 {
            increaseAlpha = false
            
        // if alpha is 0.4 or lower, start increasing alpha
        } else if talkButton.alpha <= 0.4 {
            increaseAlpha = true
        }
    }
    
    // While transcribing, animate 3 dots like it's the 90s
    func animateLabel() {
        switch infoLabel.text! {
        case "":
            infoLabel.text = "."
            break
        case ".":
            infoLabel.text = ".."
            break
        case "..":
            infoLabel.text = "..."
            break
        default:
            infoLabel.text = ""
            break
        }
    }
}
