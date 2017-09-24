//
//  ArtistIndexMO+CoreDataClass.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


public class ArtistIndexMO: NSManagedObject {

    func populate(fromDict data: [String: Any]) {
        self.name = data["name"] as? String
    }

}
