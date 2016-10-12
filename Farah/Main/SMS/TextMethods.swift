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
    
    func handleText(from string: String) {
        // Create properties to use
        var textingFullName = false
        var person = ""
        var phoneNumber = [""]
        var message = ""
        
        self.UIrespond(with: textingMessage)
        
        // Create array of words in message
        var messageArray = string.components(separatedBy: " ")
        
        // Fail check that needs to be fixed with multi line communication
        if messageArray.count < 3 {
            if let person = messageArray[safe: 1] {
                phoneNumber  = getNumber(from: person)
                openSMS(with: message, to: phoneNumber)
            } else {
                UIrespond(with: failureMessage)
            }
            return
        }
        
        // Check if the 3rd word is capital. If it is, assume it's a surname.
        if messageArray[2].components(separatedBy: "")[0].contains(itemFrom: "[A-Z]") {
            textingFullName = true
            person = "\(messageArray[1].capitalized) \(messageArray[2].capitalized)"
        } else {
            // Let the person be the 2nd word in the messageArray
            person = messageArray[1].capitalized
        }
        
        // Remove 'Text Person' from messageArray
        messageArray.remove(at: 0)
        messageArray.remove(at: 0)
        
        // Get Phone Number Ready to send.
        phoneNumber = getNumber(from: person)
        

        if textingFullName {
            // If no message
            if messageArray.count <= 1 {
                
                // Just text user.
                message = ""
                openSMS(with: message, to: phoneNumber)
                
            // If full name with message
            } else {
                
                // remove surname.
                messageArray.remove(at: 0)
            }
        }
        
        // Capitalize the first word
        messageArray[0] = messageArray[0].capitalized
        
        // Add all the words together in one message
        message = messageArray.joined(separator: " ")
        
        // Open the SMS view to text phoneNumber with message
        // Need to add possibility of nil message or phoneNumber above
        openSMS(with: message, to: phoneNumber)
        
        return
    }
    
    func getNumber(from person: String) -> [String] {
        var phoneNumber = ""
        if person.isPhoneNumber() {
            phoneNumber = person
        } else {
            // Or else find the phoneNumber from contacts
            phoneNumber = findPhoneNumber(from: person)
        }
        
        return [phoneNumber]
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
