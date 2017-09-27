//
//  TrackMO+CoreDataProperties.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/27/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


extension TrackMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackMO> {
        return NSFetchRequest<TrackMO>(entityName: "Track")
    }

    @NSManaged public var album: String?
    @NSManaged public var albumId: Int16
    @NSManaged public var artist: String?
    @NSManaged public var artistId: Int16
    @NSManaged public var bitRate: Int16
    @NSManaged public var contentType: String?
    @NSManaged public var coverArt: String?
    @NSManaged public var duration: Int16
    @NSManaged public var fileExists: Bool
    @NSManaged public var genre: String?
    @NSManaged public var id: Int16
    @NSManaged public var parent: Int16
    @NSManaged public var path: String?
    @NSManaged public var size: Int16
    @NSManaged public var suffix: String?
    @NSManaged public var title: String?
    @NSManaged public var track: Int16
    @NSManaged public var year: Int16
    @NSManaged public var forAlbum: AlbumMO?
    @NSManaged public var genres: NSSet?
    @NSManaged public var playlists: NSSet?

}

// MARK: Generated accessors for genres
extension TrackMO {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreMO)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreMO)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

// MARK: Generated accessors for playlists
extension TrackMO {

    @objc(addPlaylistsObject:)
    @NSManaged public func addToPlaylists(_ value: PlaylistMO)

    @objc(removePlaylistsObject:)
    @NSManaged public func removeFromPlaylists(_ value: PlaylistMO)

    @objc(addPlaylists:)
    @NSManaged public func addToPlaylists(_ values: NSSet)

    @objc(removePlaylists:)
    @NSManaged public func removeFromPlaylists(_ values: NSSet)

}
