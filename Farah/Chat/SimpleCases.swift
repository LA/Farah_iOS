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
        
        if string.contains(itemFrom: Keywords.characterCount) {
            return (Response.characterCount(from: string), true)
        }
        
        return (nil, false)
    }
    
    static func sayDoingWell(from string: String) -> (String?, Bool) {
        
        if string.contains(itemFrom: Keywords.doingWell) {
            return (Response.doingWell, true)
        }
        
        return (nil, false)
    }
    
    static func sayIAm(from string: String) -> (String?, Bool) {
        
        if string.contains(itemFrom: Keywords.iAm) {
            return (Response.iAm, true)
        }
        
        return (nil, false)
    }
    
    static func sayNotMuch(from string: String) -> (String?, Bool) {
        
        if string.contains(itemFrom: Keywords.notMuch) {
            return (Response.notMuch, true)
        }

        return (nil, false)
    }
    
    static func doesNotUnderstand() -> String {
        return Response.doesNotUnderstand
    }
}
