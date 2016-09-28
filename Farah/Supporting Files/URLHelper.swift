//
//  URLHelper.swift
//  SocialSwift
//
//  Created by Adar Butel on 7/13/16.
//  Copyright © 2016 Adar Butel. All rights reserved.
//

import Foundation
import UIKit

class URLHelper {
    
    static func schemeAvailable(_ scheme: String) -> Bool {
        if let url = URL.init(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    static func openAction(with url: URL) {
        if schemeAvailable(url.absoluteString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
