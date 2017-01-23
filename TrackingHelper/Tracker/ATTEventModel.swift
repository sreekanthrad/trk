//
//  ATTEventModel.swift
//  TrackingHelper
//
//  Created by Sreekanth R on 20/01/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import UIKit
import CoreLocation

class ATTEventModel: NSObject {
    public var eventType:String?
    public var eventName:String?
    public var eventStartTime:Date?
    public var eventDuration:Double?
    public var latitude:CLLocationDegrees?
    public var longitude:CLLocationDegrees?
    
    override init() {
        super.init()
    }
    
    convenience init(eventType:String?,
                     eventName name:String?,
                     eventStartTime startTime:Date?,
                     eventDuration:Double?,
                     latitude lat:CLLocationDegrees?,
                     longitude log:CLLocationDegrees?) {
        self.init()
        
        self.eventType = eventType
        self.eventName = name
        self.eventStartTime = startTime
        self.eventDuration = eventDuration
        self.latitude = lat
        self.longitude = log
    }
}
