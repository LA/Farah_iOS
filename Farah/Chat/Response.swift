//
//  Response.swift
//  Farah
//
//  Created by Adar Butel on 9/24/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation

struct Response {
    
    // MARK: Common Responses
    static func characterCount(from str: String) -> String {
        return "Your message is \(str.characters.count) characters long."
    }
    
    static let doingWell = "I'm doing well. Thank you for asking."
    static let iAm = "I am Farah."
    static let notMuch = "Not much."
    static let doesNotUnderstand = "I'm sorry, I do not understand you."
    static let location = "I live in Los Angeles, CA."
    
    static func getResponse(from key: String, with text: String) -> String {
        var response = ""
        
        switch key {
        case Keywords.characterCount:
            response = Response.characterCount(from: text)
        case Keywords.doingWell:
            response = Response.doingWell
        case Keywords.notMuch:
            response = Response.notMuch
        case Keywords.iAm:
            response = Response.iAm
        case Keywords.location:
            response = Response.location
        default:
            return response
        }
        
        return response
    }
    
    // MARK: Grab Responses
    static func grabSimpleResponse(from text: String) -> (String, Bool) {
        
        // Texting
        if SimpleCases.text(from: text) {
            return ("text", true)
        }
        
        if SimpleCases.check(text).1 {
            let response = Response.getResponse(from: SimpleCases.check(text).0!, with: text)
            return (response, true)
        }
        
        return (Response.doesNotUnderstand, true)
    }
}
