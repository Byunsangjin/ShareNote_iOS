//
//  Date+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/24.
//

import Foundation

extension Date {
    func getYearString() -> String {
        return ""
    }
    
    func getMonthString() -> String {
        return ""
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
