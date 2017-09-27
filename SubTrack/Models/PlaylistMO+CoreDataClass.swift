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
    
    class func populate(fromDict data: [String: Any], context: NSManagedObjectContext) -> PlaylistMO {
        let mo = PlaylistMO(context: context)
        mo.id = data["id"] as! Int16
        mo.songCount = data["songCount"] as! Int16
        mo.duration = data["duration"] as! Int16
        mo.name = data["name"] as? String
        if let entries = data[Constants.SubSonicAPI.Results.Entry] as? [[String: Any]] {
            let filteredEntries = entries.filter { !($0["isVideo"] as! Bool) }
            let trackObjects = TrackMO.populate(fromArray: filteredEntries, context: context)
            mo.addToTracks(trackObjects)
        }
        return mo
    }
    
    class func populate(fromArray array: [[String: Any]], context: NSManagedObjectContext) -> NSSet {
        let datas = array.map { PlaylistMO.populate(fromDict: $0, context: context) }
        return NSSet(array: datas)
    }

}
