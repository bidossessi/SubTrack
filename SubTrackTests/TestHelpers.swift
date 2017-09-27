//
//  CoreDataHelpers.swift
//  SubTrackTests
//
//  Created by Stanislas Sodonon on 9/27/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Foundation
import CoreData

struct TestConstants {
    static let backgroundSaveComplete = NSNotification.Name("it's done")
}

public func makeTestContainer(name: String) -> NSPersistentContainer {
    let container = NSPersistentContainer(name: name)
    let notif = NotificationCenter.default
    let completeSignal = "It's Done"
    func updateFromBackground(notification: Notification) {
        print("Merging changes from background")
        container.viewContext.mergeChanges(fromContextDidSave: notification)
        notif.post(name: TestConstants.backgroundSaveComplete, object: nil)
    }

    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    container.persistentStoreDescriptions = [description]
    
    container.loadPersistentStores { (storeDescription, error) in
        if let error = error {
            fatalError("Failed to load store: \(error)")
        }
    }
    notif.addObserver(forName: .NSManagedObjectContextDidSave,
                      object: nil,
                      queue: nil,
                      using: updateFromBackground)
    return container
}
