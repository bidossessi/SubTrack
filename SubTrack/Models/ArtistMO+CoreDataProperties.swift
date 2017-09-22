//
//  ArtistMO+CoreDataProperties.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


extension ArtistMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArtistMO> {
        return NSFetchRequest<ArtistMO>(entityName: "Artist")
    }

    @NSManaged public var albumCount: Int16
    @NSManaged public var coverArt: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?

}
