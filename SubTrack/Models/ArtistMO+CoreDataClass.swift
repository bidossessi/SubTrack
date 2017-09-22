//
//  ArtistMO+CoreDataClass.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


public class ArtistMO: NSManagedObject {

    init(json: [String: Any], context: NSManagedObjectContext) throws {
        let entity = NSEntityDescription.entity(forEntityName: "Artist", in: context)!
        super.init(entity: entity, insertInto: context)
        
        // Initialize properties
        self.id = json["id"] as! Int16
        self.albumCount = json["albumCount"] as! Int16
        self.coverArt = json["coverArt"] as? String
        self.name = json["name"] as? String
    }
    
}
