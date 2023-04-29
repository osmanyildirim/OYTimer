//
//  State.swift
//  OYTimer
//
//  Created by osmanyildirim
//

import Foundation

public enum State {
    /// Timer completed for `.countdown` and `.after` types
    case completed
    
    /// Timer is ticking
    case ticking
}
