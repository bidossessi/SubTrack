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

    class func populate(fromDict data: [String: Any], context: NSManagedObjectContext) -> ArtistMO {
        let mo = ArtistMO(context: context)
        mo.id = data["id"] as! Int16
        mo.albumCount = data["albumCount"] as! Int16
        mo.coverArt = data["coverArt"] as? String
        mo.name = data["name"] as? String
        if let albums = data[Constants.SubSonicAPI.Results.Album] as? [[String: Any]] {
            let albumObjects = AlbumMO.populate(fromArray: albums, context: context)
            mo.addToAlbums(albumObjects)
        }
        return mo
    }

    class func populate(fromArray array: [[String: Any]], context: NSManagedObjectContext) -> NSSet {
        let datas = array.map { ArtistMO.populate(fromDict: $0, context: context) }
        return NSSet(array: datas)
    }

}
