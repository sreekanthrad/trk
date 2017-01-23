//
//  ATTCoreDataManager.swift
//  TrackingHelper
//
//  Created by Sreekanth R on 23/01/17.
//  Copyright © 2017 Sreekanth R. All rights reserved.
//

import UIKit
import CoreData

class ATTCoreDataManager: NSObject {
    // MARK: - Core Data stack
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ATTDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func createScreenView(screenViewModel:ATTScreenViewModel?) -> Void {
        if screenViewModel != nil {
            if #available(iOS 10.0, *) {
                let managedContext = self.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Screen",
                                                        in: managedContext)!
                
                let aScreen = NSManagedObject(entity: entity, insertInto: managedContext)
                
                aScreen.setValue(screenViewModel?.screenViewID, forKeyPath: "screenViewID")
                aScreen.setValue(screenViewModel?.previousScreenName, forKeyPath: "previousScreen")
                aScreen.setValue(screenViewModel?.screenName, forKeyPath: "presentScreen")
                aScreen.setValue(screenViewModel?.screeViewDuration, forKeyPath: "screenWatchDuration")
                aScreen.setValue(screenViewModel?.screenViewBeginTime, forKeyPath: "screenWatchedTime")
                aScreen.setValue(false, forKeyPath: "syncStatus")
                
                do {
                    try managedContext.save()                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
            } else {
                
            }
        }
    }
    
    func fetchAllScreens() -> Array<AnyObject>? {
        if #available(iOS 10.0, *) {
            let managedContext = self.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Screen")
            do {
                let data:Array<AnyObject> = try managedContext.fetch(fetchRequest)
                return data
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    // MARK: - Core Data Saving support    
    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = self.persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {                    
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
