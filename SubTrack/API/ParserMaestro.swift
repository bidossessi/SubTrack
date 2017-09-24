//
//  ParserMaestro.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/23/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Foundation
import CoreData

protocol ParserMaestro: class {
    static var shared: ParserMaestro { get }
    func createObject(index: [String: Any], context: NSManagedObjectContext)
    func createObject(artist: [String: Any], context: NSManagedObjectContext)
    func createObject(album: [String: Any], context: NSManagedObjectContext)
    func createObject(track: [String: Any], context: NSManagedObjectContext)
    func createObject(genre: [String: Any], context: NSManagedObjectContext)
    func createObject(playlist: [String: Any], context: NSManagedObjectContext)
    func validate(version: String) throws
    func validate(status: String) throws
    func queryMaestro(_ api: HTTPMaestro, requestData data: Data, container: NSPersistentContainer)
}

extension ParserMaestro {
    
    func validate(version: String) throws {
        let apiVersion = NSString(string: Constants.SubSonicInfo.apiVersion)
        let options = NSString.CompareOptions.numeric
        let r = apiVersion.compare(version, options: options)
        if r == ComparisonResult.orderedDescending {
            fatalError("Api too old: \(version); minimum required: \(Constants.SubSonicInfo.apiVersion)")
        }
    }
    
    func validate(status: String) throws {
        if status != Constants.SubSonicInfo.RequestStatusOK {
            fatalError("Subsonic server rejected the request")
        }
    }
    
    func createObject(index: [String: Any], context: NSManagedObjectContext) {
        let mo = ArtistIndexMO(context: context)
        mo.populate(fromDict: index)
        if let artists = index[Constants.SubSonicAPI.Results.Artist] as? [[String: Any]] {
            for artist in artists {
                // TODO: handle one2Many
                self.createObject(artist: artist, context: context)
            }
        }
    }

    func createObject(artist: [String: Any], context: NSManagedObjectContext) {
        let mo = ArtistMO(context: context)
        mo.populate(fromDict: artist)
        if let albums = artist[Constants.SubSonicAPI.Results.Album] as? [[String: Any]] {
            for album in albums {
                self.createObject(album: album, context: context)
            }
        }
    }

    func createObject(album: [String: Any], context: NSManagedObjectContext) {
        let mo = AlbumMO(context: context)
        mo.populate(fromDict: album)
        if let tracks = album[Constants.SubSonicAPI.Results.Song] as? [[String: Any]] {
            for track in tracks {
                self.createObject(track: track, context: context)
            }
        }
    }

    func createObject(track: [String: Any], context: NSManagedObjectContext) {
        let mo = TrackMO(context: context)
        mo.populate(fromDict: track)
    }

    func createObject(genre: [String: Any], context: NSManagedObjectContext) {
        let mo = GenreMO(context: context)
        mo.populate(fromDict: genre)
    }

    func createObject(playlist: [String: Any], context: NSManagedObjectContext) {
        let mo = PlaylistMO(context: context)
        mo.populate(fromDict: playlist)
        if let entries = playlist[Constants.SubSonicAPI.Results.Entry] as? [[String: Any]] {
            for entry in entries {
                let isVideo = entry["isVideo"] as! Bool
                if isVideo == false {
                    self.createObject(track: entry, context: context)
                }
            }
        }
    }
}
