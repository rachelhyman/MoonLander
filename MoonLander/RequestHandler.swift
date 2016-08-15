//
//  RequestHandler.swift
//  MoonLander
//
//  Created by Rachel Hyman on 8/14/16.
//  Copyright © 2016 Rachel Hyman. All rights reserved.
//

import UIKit
import CoreLocation

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
    var apiKey: String?
    let locationManager = CLLocationManager()
    static var dateFormatter: NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DDThh:mm:ss"
        return dateFormatter
    }
    
    override init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    func locationPermissionsGiven() -> Bool {
        return CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse
    }
    
    func requestMoonPhase(forDate: NSDate, completion: MoonCompletion) {
        guard let key = apiKey else { return }
        if !locationPermissionsGiven() {
            return
        }
        guard let loc = locationManager.location else { return }
        let locationString = "\(loc.coordinate.latitude),\(loc.coordinate.longitude)"
        let urlString = "https://api.forecast.io/forecast/\(key)/\(locationString),2016-08-16T12:00:00"
        guard let url = NSURL(string: urlString) else { return }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) {
            (optionalData, response, error) -> Void in
            guard let data = optionalData else { return }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
                print(json)
            } catch {
                
            }
            
        }
        task.resume()
    }
}
