//
//  AppDelegate.swift
//  MoonLander
//
//  Created by Rachel Hyman on 8/14/16.
//  Copyright © 2016 Rachel Hyman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        guard let key = retrieveAPIKey() else {
            print("could not retrieve api key")
            return true
        }
        if let window = self.window {
            let rootVC = window.rootViewController as? ViewController
            let requestHandler = RequestHandler()
            requestHandler.apiKey = key
            rootVC?.requestHandler = requestHandler
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func retrieveAPIKey() -> String? {
        guard let url = NSBundle.mainBundle().URLForResource("credentials", withExtension: "json") else {
            print("credentials json not found")
            return nil
        }
        guard let data = NSData(contentsOfURL: url) else {
            print("error initializing data from file url")
            return nil
        }
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
            if let key = json["FORECAST_API_KEY"] as? String {
                return key
            }
            
        } catch {
            print("json serialization error: \(error)")
        }
        return nil
    }
}

