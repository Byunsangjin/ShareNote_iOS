//
//  Date+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/24.
//

import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    // Date에서 년.월 형태로 반환하는 메소드
    func getYearMonthString() -> String {
        let dateComponent = self.get(.year, .month, .day)
        
        guard let year = dateComponent.year, let month = dateComponent.month  else {
            return ""
        }
        
        let formattedMonth = String(format: "%02d", month)
        return "\(year).\(formattedMonth)"
    }
}
