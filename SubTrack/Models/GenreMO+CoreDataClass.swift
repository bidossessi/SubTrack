//
//  GenreMO+CoreDataClass.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/22/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//
//

import Foundation
import CoreData


public class GenreMO: NSManagedObject {

    func populate(fromDict data: [String: Any]) {
        self.songCount = data["songCount"] as! Int16
        self.albumCount = data["albumCount"] as! Int16
        self.name = data["value"] as? String
    }    

}
