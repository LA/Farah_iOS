//
//  Keywords.swift
//  Farah
//
//  Created by Adar Butel on 10/1/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation

struct Keywords {
    
    static let characterCount = "^[Hh]ow .* character[s]?"
    
    static let doingWell = "^[Hh]ow are you"
    
    static let iAm = "(^[Ww]ho|[Ww]hat).*(you|this)"
    
    static let notMuch = "[Ww]hat.*(up|happening|going on|good)"
    
    static let text = "(^[Tt]ext) (\(String.phoneNumberRegex)|[a-zA-Z]*) (.*$)"
    
    static let location = "[Ww](here|hat).*(live|your home|location|you from)"
}
