//
//  AlbumMO+CoreDataClass.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


public class AlbumMO: NSManagedObject {
    
    class func populate(fromDict data: [String: Any], context: NSManagedObjectContext) -> AlbumMO {
        let mo = AlbumMO(context: context)

        let id = data["id"] as! NSNumber
        mo.id = id.int16Value
        if let parent = data["parent"] as? NSNumber {
            mo.parent = parent.int16Value
        }
        let artistId = data["artistId"] as! NSNumber
        mo.artistId = artistId.int16Value
        let songCount = data["songCount"] as! NSNumber
        mo.songCount = songCount.int16Value
        let duration = data["duration"] as! NSNumber
        mo.duration = duration.int16Value
        if let year = data["year"] as? NSNumber {
            mo.year = year.int16Value
        }
        mo.artist = data["artist"] as? String
        mo.album = data["album"] as? String
        mo.genre = data["genre"] as? String
        mo.name = data["name"] as? String
        mo.coverArt = data["coverArt"] as? String
        mo.title = data["title"] as? String
        if let forArtist = data["forArtist"] as? ArtistMO {
            mo.forArtist = forArtist
        }
        if let tracks = data[Constants.SubSonicAPI.Results.Song] as? [[String: Any]] {
            let trackObjects = TrackMO.populate(fromArray: tracks, context: context)
            mo.addToTracks(trackObjects)
        }
        return mo
    }

    class func populate(fromArray array: [[String: Any]], context: NSManagedObjectContext) -> NSSet {
        let datas = array.map { AlbumMO.populate(fromDict: $0, context: context) }
        return NSSet(array: datas)
    }

}
