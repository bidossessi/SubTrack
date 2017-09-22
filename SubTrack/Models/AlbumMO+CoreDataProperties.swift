//
//  AlbumMO+CoreDataProperties.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


extension AlbumMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumMO> {
        return NSFetchRequest<AlbumMO>(entityName: "Album")
    }

    @NSManaged public var album: String?
    @NSManaged public var artist: String?
    @NSManaged public var artistId: Int16
    @NSManaged public var coverArt: String?
    @NSManaged public var genre: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var parent: Int16
    @NSManaged public var songCount: Int16
    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    @NSManaged public var duration: Int16

}
