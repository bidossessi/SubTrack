//
//  AlbumMO+CoreDataProperties.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/27/17.
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
    @NSManaged public var duration: Int16
    @NSManaged public var genre: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var parent: Int16
    @NSManaged public var songCount: Int16
    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    @NSManaged public var forArtist: ArtistMO?
    @NSManaged public var tracks: NSSet?

}

// MARK: Generated accessors for tracks
extension AlbumMO {

    @objc(addTracksObject:)
    @NSManaged public func addToTracks(_ value: TrackMO)

    @objc(removeTracksObject:)
    @NSManaged public func removeFromTracks(_ value: TrackMO)

    @objc(addTracks:)
    @NSManaged public func addToTracks(_ values: NSSet)

    @objc(removeTracks:)
    @NSManaged public func removeFromTracks(_ values: NSSet)

}
