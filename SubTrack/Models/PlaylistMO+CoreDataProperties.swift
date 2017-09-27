//
//  PlaylistMO+CoreDataProperties.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/27/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


extension PlaylistMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaylistMO> {
        return NSFetchRequest<PlaylistMO>(entityName: "Playlist")
    }

    @NSManaged public var duration: Int16
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var songCount: Int16
    @NSManaged public var tracks: NSSet?

}

// MARK: Generated accessors for tracks
extension PlaylistMO {

    @objc(addTracksObject:)
    @NSManaged public func addToTracks(_ value: TrackMO)

    @objc(removeTracksObject:)
    @NSManaged public func removeFromTracks(_ value: TrackMO)

    @objc(addTracks:)
    @NSManaged public func addToTracks(_ values: NSSet)

    @objc(removeTracks:)
    @NSManaged public func removeFromTracks(_ values: NSSet)

}
