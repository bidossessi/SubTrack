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

    class func populate(fromDict data: [String: Any], context: NSManagedObjectContext) -> TrackMO {
        let mo = TrackMO(context: context)
        mo.id = data["id"] as! Int16
        mo.parent = data["parent"] as! Int16
        mo.track = data["track"] as! Int16
        mo.artistId = data["artistId"] as! Int16
        mo.albumId = data["albumId"] as! Int16
        mo.duration = data["duration"] as! Int16
        mo.size = data["size"] as! Int16
        mo.bitRate = data["bitRate"] as! Int16
        mo.year = data["year"] as! Int16
        mo.artist = data["artist"] as? String
        mo.album = data["album"] as? String
        mo.genre = data["genre"] as? String
        mo.coverArt = data["coverArt"] as? String
        mo.title = data["title"] as? String
        mo.path = data["path"] as? String
        mo.contentType = data["contentType"] as? String
        mo.suffix = data["suffix"] as? String
        if let forAlbum = data["forAlbum"] as? AlbumMO {
            mo.forAlbum = forAlbum
        }
        if let playlist = data["playlist"] as? PlaylistMO {
            mo.addToPlaylists(playlist)
        }
        return mo
    }
    
    class func populate(fromArray array: [[String: Any]], context: NSManagedObjectContext) -> NSSet {
        let datas = array.map { TrackMO.populate(fromDict: $0, context: context) }
        return NSSet(array: datas)
    }

}
