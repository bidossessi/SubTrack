//
//  PlaylistMO+CoreDataClass.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


public class PlaylistMO: NSManagedObject {
    
    func populate(fromDict data: [String: Any]) {
        self.id = data["id"] as! Int16
        self.songCount = data["songCount"] as! Int16
        self.duration = data["duration"] as! Int16
        self.name = data["name"] as? String
    }

}
