//
//  Date+StringFormat.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 17/09/2021.
//

import Foundation

extension Date {
    
    func toString(dateStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        return formatter.string(from: self)
    }
    
}
