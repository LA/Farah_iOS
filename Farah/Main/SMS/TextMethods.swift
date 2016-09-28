//
//  TextMethods.swift
//  Farah
//
//  Created by Adar Butel on 9/26/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation
import MessageUI

private let failureMessage = "Text Message could not be sent."
private let textingMessage = "Texting..."
private let successMessage = "Successfully sent your text."

extension MainViewController: MFMessageComposeViewControllerDelegate {
    
    // Open Text
    func openSMS(with message: String, to people: [String]?) {
        let msgVC = SMSHelper.send(message, to: people)
        msgVC.messageComposeDelegate = self
        self.present(msgVC, animated: true, completion: nil)
    }
    
    func textUser(from string: String) {
        
        let message = string.lowercased()
        
        if (message.contains("text")) {
            
            self.respond(with: textingMessage)
            
            let messageArray = string.components(separatedBy: " ")
            
            if let textIndex = messageArray.index(of: "text") ?? messageArray.index(of: "Text") {
                
                let personIndex = textIndex.advanced(by: 1)
                
                if let person = messageArray[safe: personIndex]?.capitalized {
                    
                    let fixedPerson = [person.capitalized]
                    
                    var fixedMessageArray = Array(messageArray[personIndex + 1...messageArray.endIndex - 1])
                    
                    fixedMessageArray[0] = fixedMessageArray[0].capitalized
                    
                    let fixedMessage = fixedMessageArray.joined(separator: " ")
                    
                    openSMS(with: fixedMessage, to: fixedPerson)
                    
                    return
                }
            }
            
            self.respond(with: failureMessage)
        }
    }
    
    // MARK: - Message Protocol Methods
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResult.cancelled.rawValue, MessageComposeResult.failed.rawValue:
            respond(with: failureMessage)
        case MessageComposeResult.sent.rawValue:
            respond(with: successMessage)
        default:
            break
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
}
