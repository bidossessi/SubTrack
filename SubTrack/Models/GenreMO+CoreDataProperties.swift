//
//  GenreMO+CoreDataProperties.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


extension GenreMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreMO> {
        return NSFetchRequest<GenreMO>(entityName: "Genre")
    }

    @NSManaged public var albumCount: Int16
    @NSManaged public var songCount: Int16
    @NSManaged public var name: String?

}
