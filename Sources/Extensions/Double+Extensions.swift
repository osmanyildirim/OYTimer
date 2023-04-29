//
//  Double+Extensions.swift
//  OYTimer
//
//  Created by osmanyildirim
//

import Foundation

public extension Double {
    /// `100.millisecond_s`
    var millisecond_s: TimeInterval {
        return self / 1000
    }

    /// `10.second_s`
    var second_s: TimeInterval {
        self
    }

    /// `3.minute_s`
    var minute_s: TimeInterval {
        return self.second_s * 60
    }

    /// `2.hour_s`
    var hour_s: TimeInterval {
        return self.minute_s * 60
    }

    /// `1.day_s`
    var day_s: TimeInterval {
        return self.hour_s * 24
    }
}
