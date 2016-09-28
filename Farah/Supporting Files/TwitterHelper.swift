//
//  TwitterHelper.swift
//  SocialSwift
//
//  Created by Adar Butel on 7/13/16.
//  Copyright © 2016 Adar Butel. All rights reserved.
//

import Foundation
import UIKit

class TwitterHelper {
    
    static func openTimeline() {
        if let timelineURL = URL.init(string: "twitter://timeline") {
            URLHelper.openAction(with: timelineURL)
        }
    }
    
    static func openMentions() {
        if let mentURL = URL.init(string: "twitter://mentions") {
            URLHelper.openAction(with: mentURL)
        }
    }
    
    static func openMessages() {
        if let msgURL = URL.init(string: "twitter://mentions") {
            URLHelper.openAction(with: msgURL)
        }
    }
    
    static func openProfile(of username: String?, with id: String?) {
        if username != nil {
            if let profileURL = URL.init(string: "twitter://user?screen_name=\(username!)") {
                URLHelper.openAction(with: profileURL)
            }
        } else if id != nil && username == nil {
            if let profileURL = URL.init(string: "twitter://user?screen_name=\(id!)") {
                URLHelper.openAction(with: profileURL)
            }
        }
    }
    
    static func openStatus(with id: String) {
        if let mediaURL = URL.init(string: "twitter://status?id=\(id)") {
            URLHelper.openAction(with: mediaURL)
        }
    }
    
    static func openSearch(with query: String) {
        if let searchURL = URL.init(string: "search?query=%23\(query)") {
            URLHelper.openAction(with: searchURL)
        }
    }
    
    static func post(_ msg: String, inReplyToStatus id: String?) {
        // Use %20 for ' '
        if id == nil {
            if let postURL = URL.init(string: "post?message=\(msg)") {
                URLHelper.openAction(with: postURL)
            }
        } else {
            if let postURL = URL.init(string: "post?message=\(msg)&in_reply_to_status_id=\(id)") {
                URLHelper.openAction(with: postURL)
            }
        }
    }
}
