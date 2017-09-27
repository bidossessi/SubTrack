//
//  ArtistIndexMO+CoreDataProperties.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/27/17.
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
    @NSManaged public var artists: NSSet?

}

// MARK: Generated accessors for artists
extension ArtistIndexMO {

    @objc(addArtistsObject:)
    @NSManaged public func addToArtists(_ value: ArtistMO)

    @objc(removeArtistsObject:)
    @NSManaged public func removeFromArtists(_ value: ArtistMO)

    @objc(addArtists:)
    @NSManaged public func addToArtists(_ values: NSSet)

    @objc(removeArtists:)
    @NSManaged public func removeFromArtists(_ values: NSSet)

}
