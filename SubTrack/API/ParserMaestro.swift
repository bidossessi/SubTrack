//
//  ParserMaestro.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/23/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Foundation
import CoreData

protocol ParserMaestro: class {
    static var shared: ParserMaestro { get }
    func validate(version: String) throws
    func validate(status: String) throws
    func parse(data: Data) throws -> [String: Any]
    func process(dataObject: [String: Any], context: NSManagedObjectContext)
    func persist(response: [String: Any], container: NSPersistentContainer) throws
    func parse(requestData data: Data, container: NSPersistentContainer) throws

}

extension ParserMaestro {
    
    func validate(version: String) throws {
        let apiVersion = NSString(string: Constants.SubSonicInfo.apiVersion)
        let options = NSString.CompareOptions.numeric
        let r = apiVersion.compare(version, options: options)
        if r == ComparisonResult.orderedDescending {
            fatalError("Api too old: \(version); minimum required: \(Constants.SubSonicInfo.apiVersion)")
        }
    }
    
    func validate(status: String) throws {
        if status != Constants.SubSonicInfo.RequestStatusOK {
            fatalError("Subsonic server rejected the request")
        }
    }
    
    func persist(response: [String: Any], container: NSPersistentContainer) throws {
        container.performBackgroundTask() { (context) in
            // Do the work
            context.automaticallyMergesChangesFromParent = true
            context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            self.process(dataObject: response, context: context)
            // Save changes
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func parse(requestData data: Data, container: NSPersistentContainer) throws {
        do {
            let response = try self.parse(data: data)
            try self.persist(response: response, container: container)
        } catch {
            fatalError("Failed to parse data to store: \(error)")
        }
    }
    
}
