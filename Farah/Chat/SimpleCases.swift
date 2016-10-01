//
//  SimpleCases.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation

struct SimpleCases {
    
    static func sayCharacterCount(from string: String) -> (String?, Bool) {
        
        let message = string.lowercased()
        
        for keyword in Keywords.characterCount {
            if message.contains(keyword) {
                return ("Your message is \(string.characters.count) characters long.", true)
            }
        }
        
        return (nil, false)
    }
    
    static func sayDoingWell(from string: String) -> (String?, Bool) {
        
        let message = string.lowercased()
        
        for keyword in Keywords.doingWell {
            if message.contains(keyword) {
                return ("I'm doing well. Thank you for asking.", true)
            }
        }
        
        return (nil, false)
    }
    
    static func sayIAm(from string: String) -> (String?, Bool) {
        
        let message = string.lowercased()
        
        for keyword in Keywords.iAm {
            if message.contains(keyword) {
                return ("I am Farah, a chat bot, created in Swift 3 by Adar Butel.", true)
            }
        }
        return (nil, false)
    }
    
    static func sayNotMuch(from string: String) -> (String?, Bool) {
        
        let message = string.lowercased()
        
        if message.contains("what's") {
            for keyword in Keywords.notMuch {
                if message.contains(keyword) {
                    return ("Not much.", true)
                }
            }
        }
        
        return (nil, false)
    }
    
    static func doesNotUnderstand() -> String {
        return "I'm sorry, I do not understand you."
    }
}
