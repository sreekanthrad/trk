//
//  ViewController.swift
//  TrackingHelper
//
//  Created by Sreekanth R on 08/11/16.
//  Copyright © 2016 Sreekanth R. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewController2:ViewController2?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadACustomData()        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadACustomData() -> Void {        
        let customEvent = ATTCustomEvent()
        let customArguments = ["param1":"value1", "param2":"value2"]
        
        customEvent.eventStarted()
        
        let url = NSURL(string: "http://www.stackoverflow.com")
        let task = URLSession.shared.dataTask(with: url! as URL) {(data, response, error) in
            customEvent.eventFinished()
            ATTAnalytics.helper.registerForTracking(appSpecificKeyword: "ACustomEvent",
                                                    dataURL: "http://www.stackoverflow.com",
                                                    customArguments: customArguments as Dictionary<String, AnyObject>?,
                                                    customEvent: customEvent)
        }
        
        task.resume()
    }
    
    @IBAction func simpleButtonClick(_ sender: Any) {
        // There is no explicit calls required inside the method to track automatically
    }
    
    @IBAction func customButtonClick(_ sender: Any) {
        // Explict calls with custom parameters
        let customArguments = ["param1":"value1", "param2":"value2"]
        
        let customEvent = ATTCustomEvent()
        customEvent.eventStarted()
        customEvent.eventFinished()
        
        ATTAnalytics.helper.registerForTracking(appSpecificKeyword: "ACustomEvent",
                                                dataURL: "http://www.google.com",
                                                customArguments: customArguments as Dictionary<String, AnyObject>?,
                                                customEvent: customEvent)
    }

    // Example of Screen change traking on pushViewControlelr
    @IBAction func pushView(_ sender: Any) {
        self.performSegue(withIdentifier: "ViewController2", sender: nil)
    }
    
    // Example of screen change tracking on presentViewControlelr
    @IBAction func presentView(_ sender: Any) {
        self.performSegue(withIdentifier: "ModalPresentation", sender: nil)
    }
    
    // Example of screen change traking on addSubView
    @IBAction func addSubview(_ sender: Any) {
        self.viewController2 = nil
        self.viewController2 = ViewController2()
        self.viewController2?.view.frame = CGRect(origin: CGPoint(x: 10,y :350), size: CGSize(width: 100, height: 100))
        self.viewController2?.view.backgroundColor = UIColor.red
        
        self.view.addSubview((self.viewController2?.view)!)
    }
    
    // Example of App crash tracking
    // Events will be triggered in the next app launch
    @IBAction func crashTheApp(_ sender: Any) {
        preconditionFailure()
    }
    
    @IBAction func arrayOutOfBounds(_ sender: Any) {
        let arr = ["A"]
        print("\(arr[2])")
    }
    
    @IBAction func nilDict(_ sender: Any) {
        var dict = Dictionary<String, AnyObject>()
        print("\(dict["A"]!)")
    }
}

