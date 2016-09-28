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
        
        let store = CNContactStore()
        
        do {
            
            print("Made it here")
            
            let contacts = try store.unifiedContacts(matching: CNContact.predicateForContacts(matchingName: name), keysToFetch:[CNContactGivenNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor])
            
            if let phoneNumber = (contacts[safe: 0]?.phoneNumbers[safe: 0]?.value)?.value(forKey: "digits") as? String {
                return phoneNumber
            } else {
                respond(with: couldNotFindContactMessage)
                return ""
            }
            
        } catch {
            respond(with: couldNotAccessContactsMessage)
        }
        
        return ""
    }
}
