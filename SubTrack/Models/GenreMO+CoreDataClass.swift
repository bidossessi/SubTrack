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

    class func populate(fromDict data: [String: Any], context: NSManagedObjectContext) -> GenreMO {
        let mo = GenreMO(context: context)
        mo.songCount = data["songCount"] as! Int16
        mo.albumCount = data["albumCount"] as! Int16
        mo.name = data["value"] as? String
        return mo
    }
    
    class func populate(fromArray array: [[String: Any]], context: NSManagedObjectContext) -> NSSet {
        let datas = array.map { GenreMO.populate(fromDict: $0, context: context) }
        return NSSet(array: datas)
    }

}
