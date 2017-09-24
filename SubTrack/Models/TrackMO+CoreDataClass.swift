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

    func populate(fromDict data: [String: Any]) {
        self.id = data["id"] as! Int16
        self.parent = data["parent"] as! Int16
        self.track = data["track"] as! Int16
        self.artistId = data["artistId"] as! Int16
        self.albumId = data["albumId"] as! Int16
        self.duration = data["duration"] as! Int16
        self.size = data["size"] as! Int16
        self.bitRate = data["bitRate"] as! Int16
        self.year = data["year"] as! Int16
        self.artist = data["artist"] as? String
        self.album = data["album"] as? String
        self.genre = data["genre"] as? String
        self.coverArt = data["coverArt"] as? String
        self.title = data["title"] as? String
        self.path = data["path"] as? String
        self.contentType = data["contentType"] as? String
        self.suffix = data["suffix"] as? String

    }

}
