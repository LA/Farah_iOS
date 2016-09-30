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
    
    func animateTranscribe() {
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
