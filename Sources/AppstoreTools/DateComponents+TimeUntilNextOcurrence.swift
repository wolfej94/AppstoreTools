//
//  DateComponents+TimeUntilNextOcurrence.swift
//  
//
//  Created by James Wolfe on 05/01/2024.
//

import Foundation

extension DateComponents {
    
    func timeUntilNextOccurrence() -> TimeInterval? {
            var components = Calendar.current.dateComponents([.year, .month, .day], from: .now)
            components.hour = hour
            components.minute = minute
            components.second = second
            components.calendar = Calendar.current // Ensure the calendar is set to the appropriate one
            
            guard let today = Calendar.current.date(from: components) else { return nil }
            
        if today < .now {
            guard let tomorrow = components.adding(component: .day, value: 1)?.toDate() else { return nil }
            return tomorrow.timeIntervalSince(today)
        } else {
            return today.timeIntervalSince(.now)
        }
    }
    
    func adding(component: Calendar.Component, value: Int) -> DateComponents? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        guard let tomorrow = Calendar.current.date(byAdding: component, value: value, to: date) else { return nil }
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: tomorrow)
    }
    
    func toDate() -> Date? {
        Calendar.current.date(from: self)
    }
    
    
}
