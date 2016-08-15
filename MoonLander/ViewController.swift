//
//  ViewController.swift
//  MoonLander
//
//  Created by Rachel Hyman on 8/14/16.
//  Copyright © 2016 Rachel Hyman. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var requestHandler: RequestHandler?

    @IBOutlet weak var moonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestHandler?.locationManager.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if requestHandler?.locationPermissionsGiven() == false {
            requestHandler?.locationManager.requestWhenInUseAuthorization()
        } else {
            requestHandler?.locationManager.startUpdatingLocation()
        }
    }

    @IBAction func didTapButton(sender: AnyObject) {
        requestHandler?.requestMoonPhase(NSDate(), completion: { (phase) in
            
        })
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.last)
    }
}

