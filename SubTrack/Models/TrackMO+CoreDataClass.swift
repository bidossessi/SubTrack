//
//  TrackMO+CoreDataClass.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


public class TrackMO: NSManagedObject {

    init(json: [String: Any], context: NSManagedObjectContext) throws {
        let entity = NSEntityDescription.entity(forEntityName: "Track", in: context)!
        super.init(entity: entity, insertInto: context)
        
        // Initialize properties
        self.id = json["id"] as! Int16
        self.parent = json["parent"] as! Int16
        self.track = json["track"] as! Int16
        self.artistId = json["artistId"] as! Int16
        self.albumId = json["albumId"] as! Int16
        self.duration = json["duration"] as! Int16
        self.size = json["size"] as! Int16
        self.bitRate = json["bitRate"] as! Int16
        self.year = json["year"] as! Int16
        self.artist = json["artist"] as? String
        self.album = json["album"] as? String
        self.genre = json["genre"] as? String
        self.coverArt = json["coverArt"] as? String
        self.title = json["title"] as? String
        self.path = json["path"] as? String
        self.contentType = json["contentType"] as? String
        self.suffix = json["suffix"] as? String

    }

}
