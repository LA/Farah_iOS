//
//  SMSHelper.swift
//  SocialSwift
//
//  Created by Adar Butel on 7/22/16.
//  Copyright © 2016 Adar Butel. All rights reserved.
//

import MessageUI

class SMSHelper: UIViewController {
    
    static func send(_ msg: String, to recipients: [String]?) -> MFMessageComposeViewController {
        let messageVC = MFMessageComposeViewController()
        messageVC.body = msg
        messageVC.recipients = recipients
        
        return messageVC
    }
}
