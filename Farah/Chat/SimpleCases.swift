//
//  SimpleCases.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation

struct SimpleCases {
    
    static func check(_ string: String) -> (String?, Bool) {
        for key in Keywords.keywords {
            if string.contains(itemFrom: key) {
                return (key, true)
            }
        }
        
        return (nil, false)
    }
    
    static func text(from string: String) -> (Bool) {
        if string.contains(itemFrom: Keywords.text) {
            return true
        }
        
        return false
    }
}
