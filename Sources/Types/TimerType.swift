//
//  TimerType.swift
//  OYTimer
//
//  Created by osmanyildirim
//

import Foundation

public enum TimerType {
    /// Execute once after passed interval value
    case after(TimeInterval)
    
    /// Execute up to passed interval value
    case countdown(TimeInterval)
    
    /// Repeat execute every passed interval value
    case `repeat`
}
