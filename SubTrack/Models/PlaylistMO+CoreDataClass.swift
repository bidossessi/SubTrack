//
//  PlaylistMO+CoreDataClass.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


public class PlaylistMO: NSManagedObject {
    
    init(json: [String: Any], context: NSManagedObjectContext) throws {
        let entity = NSEntityDescription.entity(forEntityName: "Playlist", in: context)!
        super.init(entity: entity, insertInto: context)
        
        // Initialize properties
        self.id = json["id"] as! Int16
        self.songCount = json["songCount"] as! Int16
        self.duration = json["duration"] as! Int16
        self.name = json["name"] as? String
    }

}
