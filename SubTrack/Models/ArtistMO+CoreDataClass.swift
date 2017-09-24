//
//  ArtistMO+CoreDataClass.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


public class ArtistMO: NSManagedObject {

    func populate(fromDict data: [String: Any]) {
        self.id = data["id"] as! Int16
        self.albumCount = data["albumCount"] as! Int16
        self.coverArt = data["coverArt"] as? String
        self.name = data["name"] as? String
    }
    
}
