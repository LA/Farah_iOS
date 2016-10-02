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
                
        self.respond(with: textingMessage)
        
        var messageArray = string.components(separatedBy: " ")
        
        if let person = messageArray[safe: 1]?.capitalized {
            
            var phoneNumber: [String]?
            
            if person.isPhoneNumber() {
                print("true")
                phoneNumber = [person]
            } else {
                print("false")
                phoneNumber = [findPhoneNumber(from: person)]
            }
            
            messageArray.remove(at: 0)
            messageArray.remove(at: 0)
            messageArray[0] = messageArray[0].capitalized
            
            let message = messageArray.joined(separator: " ")
            
            openSMS(with: message, to: phoneNumber)
            
            return
        }
        
        self.respond(with: failureMessage)
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
