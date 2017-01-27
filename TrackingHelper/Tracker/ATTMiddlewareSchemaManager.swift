//
//  ATTMiddlewareSchemaManager.swift
//  TrackingHelper
//
//  Created by Sreekanth R on 18/01/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import UIKit
import CoreLocation

class ATTMiddlewareSchemaManager: NSObject {
    // MARK: Private properties
    private var flushManager:ATTFlushManager?
    private var screenEventsArray:Array<AnyObject>?
    
    var screenViewModel:ATTScreenViewModel?
    var locationManager:ATTLocationManager?
    var appInfo:Dictionary<String, AnyObject>?
    
    // MARK: Lazy initializations
    lazy var syncableSchemaArray: Array<AnyObject> = {
        return Array()
    }()
    
    // MARK: Lazy initializations
    lazy var coreDataManager: ATTCoreDataManager = {
        return ATTCoreDataManager()
    }()
    
    // MARK: Shared object
    /// Shared Object
    public class var manager: ATTMiddlewareSchemaManager {
        struct Static {
            static let instance = ATTMiddlewareSchemaManager()
        }
        
        return Static.instance
    }
    
    func startUpdatingLocations() -> Void {
        self.locationManager = ATTLocationManager()
    }
    
    func startFlushManager() -> Void {
        self.flushManager = ATTFlushManager(flushInterval:100, delegate:self)
    }
    
    // MARK: Screen view events
    func startNewScreenViewWithScreenID(screenViewID:String?,
                                        screenName name:String?,
                                        screenViewBeginAt screenViewBeginTime:Date?) -> Void {
        self.screenViewModel = ATTScreenViewModel(screenViewID:screenViewID,
                                                  screenName:name,
                                                  screenViewBeginAt:screenViewBeginTime,
                                                  latitude:self.locationManager?.latitude,
                                                  longitude:self.locationManager?.longitude)
        self.coreDataManager.createScreenView(screenViewModel: self.screenViewModel)
    }
    
    func updateScreenCloseDetails(previousScreen:String?, screenViewDuration duration:Double?) -> Void {
        self.screenViewModel?.previousScreenName = previousScreen
        self.screenViewModel?.screeViewDuration = duration
        self.coreDataManager.updateScreenView(screenViewModel: self.screenViewModel)
    }
    
    // MARK: Button action events
    func createIBActionEvent(eventName:String?, eventStartTime startTime:Date?) -> Void {        
        let newEvent = ATTEventModel(screenViewID:self.screenViewModel?.screenViewID,
                                     eventType:"ButtonAction",
                                     eventName:eventName,
                                     eventStartTime:startTime,
                                     eventDuration:0,
                                     latitude:self.locationManager?.latitude,
                                     longitude:self.locationManager?.longitude)
        self.coreDataManager.createEvents(event: newEvent)
    }
    
    // MARK: Button action events
    func createCustomEvent(eventName:String?,
                           eventStartTime startTime:Date?,
                           dataURL:String?,
                           customArguments arguments:Dictionary<String, AnyObject>?) -> Void {
        let newEvent = ATTEventModel(screenViewID:self.screenViewModel?.screenViewID,
                                     eventType:"CustomEvent",
                                     eventName:eventName,
                                     eventStartTime:startTime,
                                     eventDuration:0,
                                     latitude:self.locationManager?.latitude,
                                     longitude:self.locationManager?.longitude,
                                     dataURL:dataURL,
                                     customArguments:arguments)
        self.coreDataManager.createEvents(event: newEvent)
    }
}

extension ATTMiddlewareSchemaManager:ATTFlushManagerDelegate {
    func flushData() -> Array<AnyObject>? {
        self.syncableSchemaArray.removeAll()
        let allScreens = self.coreDataManager.fetchAllScreens()! as Array<AnyObject>
        
        for eachScreen in allScreens {
            if (eachScreen.value(forKeyPath: "presentScreen") as? String) == self.screenViewModel?.screenName {
                continue
            }
            
            let screenModel = ATTScreenViewModel(screenViewID:eachScreen.value(forKeyPath: "screenViewID") as? String,
                                                 screenName:eachScreen.value(forKeyPath: "presentScreen") as? String,
                                                 screenViewBeginAt:eachScreen.value(forKeyPath: "screenWatchedTime") as? Date,
                                                 latitude:eachScreen.value(forKeyPath: "latitude") as? Double,
                                                 longitude:eachScreen.value(forKeyPath: "longitude") as? Double)
            
            screenModel.previousScreenName = eachScreen.value(forKeyPath: "previousScreen") as? String
            screenModel.screeViewDuration = eachScreen.value(forKeyPath: "screenWatchDuration") as? Double
            
            let screenEvents = self.coreDataManager.fetchEventWithScreenID(screenID: screenModel.screenViewID)! as Array<AnyObject>
            
            var eventsArray = Array<AnyObject>()
            var customParam:Dictionary<String, AnyObject>?
            for eachEvent in screenEvents {
                let eventModel = ATTEventModel(screenViewID:screenModel.screenViewID,
                                               eventType:eachEvent.value(forKeyPath: "eventType") as? String,
                                               eventName:eachEvent.value(forKeyPath: "eventName") as? String,
                                               eventStartTime:eachEvent.value(forKeyPath: "eventStartTime") as? Date,
                                               eventDuration:eachEvent.value(forKeyPath: "eventDuration") as? Double,
                                               latitude:eachEvent.value(forKeyPath: "latitude") as? CLLocationDegrees,
                                               longitude:eachEvent.value(forKeyPath: "longitude") as? CLLocationDegrees)
                
                if eachEvent.value(forKeyPath: "customParam") != nil {
                    customParam = try? JSONSerialization.jsonObject(with: eachEvent.value(forKeyPath: "customParam")! as! Data, options: []) as! Dictionary<String, AnyObject>
                    eventModel.arguments = customParam
                }
                
                eventModel.dataURL = eachEvent.value(forKeyPath: "dataURL") as! String?
                
                eventsArray.append(eventModel)
            }
            
            screenModel.screenEventsArray = eventsArray
            self.syncableSchemaArray.append(screenModel)
        }
        
        return self.syncableSchemaArray
    }
    
    func removedSyncedObjects(screenIDArray:Array<String>?) -> Void {
        self.coreDataManager.removeSyncedObjects(screenIDArray: screenIDArray!)
    }
}
