//
//  Response.swift
//  Farah
//
//  Created by Adar Butel on 9/24/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation

struct Response {
    
    static func grabResponse(from text: String) -> String {
        
        // Say Character Count
        if SimpleCases.sayCharacterCount(from: text).1 {
            return SimpleCases.sayCharacterCount(from: text).0!
        }
        
        // Say Doing Well
        if SimpleCases.sayDoingWell(from: text).1 {
            return SimpleCases.sayDoingWell(from: text).0!
        }
        
        // Say I Am Farah
        if SimpleCases.sayIAm(from: text).1 {
            return SimpleCases.sayIAm(from: text).0!
        }
        
        return SimpleCases.doesNotUnderstand()
    }
}
