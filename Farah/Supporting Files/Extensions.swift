//
//  Extensions.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import Foundation
import UIKit

// Global BG Color
let homeBGColor = UIColor.white

// Info Messages
let holdDownMsg = "Hold down or tap the microphone to speak to Farah."
let speakNowMsg = "Speak now. Release to stop recording."
let transcribingMsg = ""

// Visual Format Extension
extension UIView {
    
    func addConstraints(withFormat format: String, views: UIView...) {
        var viewsDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}


// Random Number Extension
extension Int {
    
    static func randomIntFrom(_ start: Int, to end: Int) -> Int {
        var a = start
        var b = end
        // swap to prevent negative integer crashes
        if a > b {
            swap(&a, &b)
        }
        return Int(arc4random_uniform(UInt32(b - a + 1))) + a
    }
}


// Collection Extension
extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
        
    }
}


// Regex Extension
extension String {
    func contains(itemFrom regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return !results.isEmpty
            //return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    static let phoneNumberRegex = "([0-9]{1})?\\-?([0-9]{3})\\-?([0-9]{3})\\-?([0-9]{4})"
    
    func isPhoneNumber() -> Bool {
        return self.contains(itemFrom: String.phoneNumberRegex)
    }
}
