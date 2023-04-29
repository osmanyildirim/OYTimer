//
//  OYTimer.swift
//  OYTimer
//
//  Created by osmanyildirim
//

import Foundation

public protocol OYTimerProtocol {
    typealias Completable = (_ state: State, _ counter: TimeInterval?, _ remaining: TimeInterval?) -> Void

    /// Init OYTimer
    init(type: TimerType, interval: TimeInterval, runLoop: RunLoop, modes: [RunLoop.Mode])

    /// Start OYTimer with completion block
    func start(block: Completable?)
}

public final class OYTimer: OYTimerProtocol {
    private var timer: Timer?
    private var type: TimerType?
    private var counter: TimeInterval = 0
    private var interval: TimeInterval = 1
    private var countdownTotal: TimeInterval = 1
    private var runLoop = RunLoop.current
    private var modes = [RunLoop.Mode.common]

    /// Init OYTimer
    /// - Parameters:
    ///   - type: OYTimer initial type. e.g. `.after`, `.countdown`, `.repeat`
    ///   - interval: The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
    ///   - runLoop: RunLoop object processes input for sources, such as mouse, keyboard and `Timer events` from the window system. Default value is `.current`
    ///   - modes: An array of input modes for which the block may be executed. Default value is `[.common]`
    public init(type: TimerType,
                interval: TimeInterval = 1,
                runLoop: RunLoop = .current,
                modes: [RunLoop.Mode] = [.common]) {
        self.type = type
        self.runLoop = runLoop
        self.modes = modes
        self.interval = interval
    }
}

extension OYTimer {
    /// Start OYTimer with completion block
    ///
    /// - block return values
    /// `state`: .completed or .ticking
    /// `counter`: counter interval for `.repeat` type
    /// `remaining`: remaining interval for `.countdown` type
    public func start(block: Completable?) {
        guard let type else { return }

        if case .countdown(let remaining) = type {
            countdownTotal = remaining
        }

        initTimer(type: type) { timer in
            if case .countdown = type {
                self.countdownTotal -= self.interval

                if self.countdownTotal <= 0 {
                    block?(.completed, nil, 0)
                    self.stop()
                } else {
                    block?(.ticking, nil, self.countdownTotal)
                }
            } else if case .after = type {
                block?(.completed, nil, nil)
                self.stop()
            } else if case .repeat = type {
                self.counter += self.interval
                block?(.ticking, self.counter, nil)
            }
        }
    }
    
    /// Invalidate Timer object
    /// If the state is `.completed`, the timer will be invalidate
    public func stop() {
        timer?.invalidate()
    }
}

extension OYTimer {
    /// Schedule a Timer that will call `block` with `TimerType`
    /// - Parameters:
    ///   - type: OYTimer initial type. e.g. `.after`, `.countdown`, `.repeat`
    ///   - block: Completion block that will return Timer
    private func initTimer(type: TimerType, block: ((_ timer: Timer) -> Void)?) {
        var tick = TimeInterval.zero
        var delay = TimeInterval.zero

        if case .after(let value) = type {
            delay = value
            tick = 0
        } else {
            tick = interval
        }

        let fireDate = delay + tick + CFAbsoluteTimeGetCurrent()
        timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, tick, 0, 0) { runLoop in
            guard let runLoop else { return }

            if case .after = type {
                (runLoop as Timer).invalidate()
            }
            block?(runLoop)
        }
        guard let timer else { return }

        let addMode = { mode in
            self.runLoop.add(timer, forMode: mode)
        }
        modes.forEach(addMode)
    }
}
