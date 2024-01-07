//
//  File.swift
//  
//
//  Created by James Wolfe on 05/01/2024.
//

import Foundation

extension DateFormatter {
    
    convenience init(format: String) {
        self.init()
        self.dateFormat = format
        self.locale = Locale(identifier: "en_US_POSIX")
        self.timeZone = TimeZone(abbreviation: "UTC")
    }
    
}
