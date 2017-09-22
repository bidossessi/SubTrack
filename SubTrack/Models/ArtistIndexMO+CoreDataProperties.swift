//
//  ArtistIndexMO+CoreDataProperties.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


extension ArtistIndexMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArtistIndexMO> {
        return NSFetchRequest<ArtistIndexMO>(entityName: "ArtistIndex")
    }

    @NSManaged public var name: String?

}
