//
//  ATTNotificationListener.swift
//  TrackingHelper
//
//  Created by Sreekanth R on 22/12/16.
//  Copyright © 2016 Sreekanth R. All rights reserved.
//

import UIKit

class NotificationListener: NSObject {
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(NotificationListener.trackAnEvent(notification:)),
                                               name: NSNotification.Name(rawValue: ATTAnalytics.TrackingNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(NotificationListener.trackACrash(notification:)),
                                               name: NSNotification.Name(rawValue: ATTAnalytics.CrashTrackingNotification),
                                               object: nil)
    }
    
    @objc func trackAnEvent(notification:NSNotification?) -> Void {
        if notification != nil {
            let dict = notification!.object as! NSDictionary
            //print(dict)
        }
    }
    
    @objc func trackACrash(notification:NSNotification?) -> Void {
        if notification != nil {
            let dict = notification!.object as! NSDictionary
            //print(dict)
            UserDefaults.standard.set(dict, forKey: "Crash")
        }
    }
}
