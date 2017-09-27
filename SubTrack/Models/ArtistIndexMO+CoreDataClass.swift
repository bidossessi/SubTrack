//
//  ArtistIndexMO+CoreDataClass.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


public class ArtistIndexMO: NSManagedObject {

    class func populate(fromDict data: [String: Any], context: NSManagedObjectContext) -> ArtistIndexMO {
        let mo = ArtistIndexMO(context: context)
        mo.name = data["name"] as? String
        if let artists = data[Constants.SubSonicAPI.Results.Artist] as? [[String: Any]] {
            let artistsObjects = ArtistMO.populate(fromArray: artists, context: context)
            mo.addToArtists(artistsObjects)
        }
        return mo
    }

    class func populate(fromArray array: [[String: Any]], context: NSManagedObjectContext) -> NSSet {
        let datas = array.map { ArtistIndexMO.populate(fromDict: $0, context: context) }
        return NSSet(array: datas)
    }

}
