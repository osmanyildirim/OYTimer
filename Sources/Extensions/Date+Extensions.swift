//
//  Date+Extensions.swift
//  OYTimer
//
//  Created by osmanyildirim
//

import Foundation

extension Date {
    /// Convert TimeInterval to Int
    var timeInterval: Int {
        Int(timeIntervalSinceNow)
    }
}
