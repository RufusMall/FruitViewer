//
//  Timer.swift
//  FruitKit
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//
import QuartzCore

public class Timer {
    private var startTime: TimeInterval = 0
    public private(set) var isRunning = false
    
   public static func createStartedTimer() -> Timer {
        let timer = Timer()
        timer.start()
        return timer
    }
    
    public func start() {
        isRunning = true
        startTime = CACurrentMediaTime()
    }
    
    public func stop() -> TimeInterval {
        precondition(isRunning, "Tried to stop a timer without starting it")
        
        let elapsedTime = CACurrentMediaTime() - startTime
        isRunning = false
        return elapsedTime
    }
}
