//
//  AppDelegate.swift
//  TrackingHelper
//
//  Created by Sreekanth R on 08/11/16.
//  Copyright © 2016 Sreekanth R. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var gaHelper:ATTGAHelper?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector (AppDelegate.crashNotification(notification:)),
                                               name: NSNotification.Name(rawValue: "RegisterForCrashTrakingNotification"),
                                               object: nil)
        self.configureTrackingHelper()
        
        return true
    }

    func configureTrackingHelper() -> Void {
        let filePath = Bundle.main.path(forResource: "TrackingPattern", ofType: "plist")
        ATTAnalytics.helper.beginTracking(pathForConfigFile: filePath,
                                          stateTrackingType: .Automatic,
                                          actionTrackingType: .Automatic)
        
        self.gaHelper = ATTGAHelper.init(trackingID: "UA-86961292-1")
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        ATTAnalytics.helper.registerForCrashLogging()
    }

    func applicationWillTerminate(_ application: UIApplication) {}
    
    func crashNotification(notification:Notification?) -> Void {
        print("Crash : \(notification)")
    }
}

