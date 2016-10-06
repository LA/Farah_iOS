//
//  Contacts.swift
//  Farah
//
//  Created by Adar Butel on 9/28/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

private let couldNotFindContactMessage = "Could not find contact."
private let couldNotAccessContactsMessage = "Could not access contacts."


import Foundation
import Contacts

extension MainViewController {
    func findPhoneNumber(from name: String) -> String {
        
        // Create a store of contacts
        let store = CNContactStore()
        
        do {
            
            // Find contacts matching name, grab name and phone number
            let contacts = try store.unifiedContacts(matching: CNContact.predicateForContacts(matchingName: name), keysToFetch:[CNContactGivenNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor])
            
            // Let the phone number be the first matching contact's FIRST phone number
            // Need to add ability to select from mulitiple contacts here
            if let phoneNumber = (contacts[safe: 0]?.phoneNumbers[safe: 0]?.value)?.value(forKey: "digits") as? String {
                
                // Return phoneNumber to TextMethods
                return phoneNumber
                
            } else { // If there is no matching contact
                UIrespond(with: couldNotFindContactMessage)
                return ""
            }
            
        } catch { // If Farah could not access contacts
            UIrespond(with: couldNotAccessContactsMessage)
        }
        
        return ""
    }
}
