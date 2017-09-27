//
//  ArtistMO+CoreDataProperties.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/27/17.
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
    @NSManaged public var albums: NSSet?
    @NSManaged public var index: ArtistIndexMO?

}

// MARK: Generated accessors for albums
extension ArtistMO {

    @objc(addAlbumsObject:)
    @NSManaged public func addToAlbums(_ value: AlbumMO)

    @objc(removeAlbumsObject:)
    @NSManaged public func removeFromAlbums(_ value: AlbumMO)

    @objc(addAlbums:)
    @NSManaged public func addToAlbums(_ values: NSSet)

    @objc(removeAlbums:)
    @NSManaged public func removeFromAlbums(_ values: NSSet)

}
