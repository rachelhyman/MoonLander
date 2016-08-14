//
//  RequestHandler.swift
//  MoonLander
//
//  Created by Rachel Hyman on 8/14/16.
//  Copyright © 2016 Rachel Hyman. All rights reserved.
//

import UIKit

enum MoonPhase {
    case New
    case WaxingCrescent
    case FirstQuarter
    case WaxingGibbous
    case Full
    case WaningGibbous
    case LastQuarter
    case WaningCrescent
}

struct LunationNumber {
    var number: Double
    
    func moonPhase() -> MoonPhase {
        let moonPhase: MoonPhase
        switch number {
        case 0.0:
            moonPhase = .New
        case 0.0..<0.25:
            moonPhase = .WaxingCrescent
        case 0.25:
            moonPhase = .FirstQuarter
        case 0.25..<0.5:
            moonPhase = .WaxingGibbous
        case 0.5:
            moonPhase = .Full
        case 0.5..<0.75:
            moonPhase = .WaningGibbous
        case 0.75:
            moonPhase = .LastQuarter
        case 0.75..<1:
            moonPhase = .WaningCrescent
        default:
            moonPhase = .New
        }
        return moonPhase
    }
}

typealias MoonCompletion = (phase: MoonPhase) -> Void

class RequestHandler: NSObject {
    func requestMoonPhase(forDate: NSDate, completion: MoonCompletion) {
        
    }
}
