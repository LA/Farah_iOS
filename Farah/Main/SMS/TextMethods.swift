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
        
        // Send message with method from SocialSwift
        let msgVC = SMSHelper.send(message, to: people)
        msgVC.messageComposeDelegate = self
        self.present(msgVC, animated: true, completion: nil)
    }
    
    func textUser(from string: String) {
        self.UIrespond(with: textingMessage)
        
        // Create array of words in message
        var messageArray = string.components(separatedBy: " ")
        
        // Let the person be the 2nd word in the messageArray
        // Needs to be better optimized to cross-check contacts
        if let person = messageArray[safe: 1]?.capitalized {
            
            var phoneNumber: [String]?
            
            // If the 2nd word of messageArray is a phoneNumber, make that the phone number
            if person.isPhoneNumber() {
                phoneNumber = [person]
            } else {
                
                // Or else find the phoneNumber from contacts
                phoneNumber = [findPhoneNumber(from: person)]
            }
            
            // Remove 'Text Person' from messageArray
            messageArray.remove(at: 0)
            messageArray.remove(at: 0)
            
            // Capitalize the first word
            messageArray[0] = messageArray[0].capitalized
            
            // Add all the words together in one message
            let message = messageArray.joined(separator: " ")
            
            // Open the SMS view to text phoneNumber with message
            // Need to add possibility of nil message or phoneNumber above
            openSMS(with: message, to: phoneNumber)
            
            return
        }
        
        self.UIrespond(with: failureMessage)
    }
    
    // MARK: - Message Protocol Methods
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResult.cancelled.rawValue, MessageComposeResult.failed.rawValue:
            UIrespond(with: failureMessage)
        case MessageComposeResult.sent.rawValue:
            UIrespond(with: successMessage)
        default:
            break
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
}
