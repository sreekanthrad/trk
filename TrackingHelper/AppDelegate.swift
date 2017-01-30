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
    var listenenr:NotificationListener?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.configureTrackingHelper()
        
        return true
    }

    func configureTrackingHelper() -> Void {
        
        //let configFilePath = Bundle.main.path(forResource: "TrackingPattern", ofType: "plist")
        ATTAnalytics.helper.beginTracking(pathForConfigFile: nil,
                                          stateTrackingType: "Auto",
                                          methodTrackingType: "Auto")
        
        
       // self.listenenr = NotificationListener()
        
        //******** Other Different Usages *********//
        // Use any of the below
        
        //ATTTrackingHelper.helper.startTrackingWithConfiguration(configuration: configDict)
        //ATTTrackingHelper.helper.startTrackingWithConfigurationFile(pathForFile: configFilePath)
        
        /*
        ATTTrackingHelper.helper.startTrackingWithConfiguration(configuration: configDict,
                                                                stateTracking: .Automatic,
                                                                stateTrackingMethod: .OnViewDidAppear,
                                                                methodTracking: .Automatic)
        */
        //**********************************//
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        ATTAnalytics.helper.registerForCrashLogging()
    }

    func applicationWillTerminate(_ application: UIApplication) {}
}

