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
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .Date
        return datePicker
    }()
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var moonLabel: UILabel!
    static var dateFormatter: NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestHandler?.locationManager.delegate = self
        dateTextField.text = ViewController.dateFormatter.stringFromDate(NSDate())
 
        datePicker.addTarget(self, action: #selector(didChangeDatePicker), forControlEvents: .ValueChanged)
        dateTextField.inputView = datePicker
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if requestHandler?.locationPermissionsGiven() == false {
            requestHandler?.locationManager.requestWhenInUseAuthorization()
        } else {
            requestHandler?.locationManager.startUpdatingLocation()
        }
    }
    
    func didChangeDatePicker() {
        dateTextField.text = ViewController.dateFormatter.stringFromDate(datePicker.date)
        requestMoonPhase(for: datePicker.date)
    }
    
    @IBAction func didTapButton(sender: AnyObject) {
//        requestMoonPhase(for: datePicker.date)
    }
    
    func requestMoonPhase(for date: NSDate) {
        requestHandler?.requestMoonPhase(date, completion: { [weak self] (phase) in
            self?.moonLabel.text = phase.rawValue
            print(phase)
        })
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        print(locations.last)
    }
}

