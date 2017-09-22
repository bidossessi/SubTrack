//
//  PlaylistMO+CoreDataProperties.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
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

}
