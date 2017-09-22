//
//  GenreMO+CoreDataClass.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


public class GenreMO: NSManagedObject {

    init(json: [String: Any], context: NSManagedObjectContext) throws {
        let entity = NSEntityDescription.entity(forEntityName: "Genre", in: context)!
        super.init(entity: entity, insertInto: context)
        
        // Initialize properties
        self.songCount = json["songCount"] as! Int16
        self.albumCount = json["albumCount"] as! Int16
        self.name = json["value"] as? String
    }    

}
