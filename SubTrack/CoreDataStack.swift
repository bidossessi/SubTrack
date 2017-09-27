//
//  CoreDataStack.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/27/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import CoreData

protocol DataStack: class {
    func saveContext() -> NSError?
}

class CoreDataStack: NSObject, DataStack {
    
    static var shared: DataStack = CoreDataStack()
    let notif = NotificationCenter.default
    
    private override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SubTrack")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    
    func initBackgroundObserver() {
        notif.addObserver(forName: .NSManagedObjectContextDidSave,
                          object: nil,
                          queue: nil,
                          using: self.updateFromBackground)
    }
    
    func updateFromBackground(notification: Notification){
        self.persistentContainer.viewContext.mergeChanges(fromContextDidSave: notification)
        self.notif.post(name: Constants.Data.backgroundSaveComplete, object: nil)
    }

    // MARK: - Save on exit
    func saveContext() -> NSError? {
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
        }
        
        if !context.hasChanges {
            return nil
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            return nserror
        }
        return nil
    }
}
