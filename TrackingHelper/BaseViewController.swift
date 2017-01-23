//
//  BaseViewController.swift
//  TrackingHelper
//
//  Created by Sreekanth R on 22/12/16.
//  Copyright © 2016 Sreekanth R. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let originalClass = BaseViewController.self
        let originalSelector = #selector(BaseViewController.viewDidAppear(_:))
        let swizzilableSelector = #selector(BaseViewController.tester)
        
        let originalMethod = class_getInstanceMethod(originalClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(originalClass, swizzilableSelector)
        method_exchangeImplementations(originalMethod, swizzledMethod)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tester() -> Void {
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
