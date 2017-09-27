//
//  JSONRequestParser.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 9/23/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Foundation
import CoreData


class JSONRequestParser: ParserMaestro {
    
        
    static let shared: ParserMaestro = JSONRequestParser()

    private init() {
        print("JSONRequestParser started")
    }

    func parse(data: Data) throws -> [String: Any] {        
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            
            guard let response = json?[Constants.SubSonicInfo.apiResponse] as? [String: Any] else {
                fatalError("Invalid SubSonic response")
            }
            // Check the response
            try? self.validate(status: response[Constants.SubSonicInfo.RequestStatusAttr] as! String)
            try? self.validate(version: response[Constants.SubSonicInfo.APIVersionAttr] as! String)
            return response
        } else {
            fatalError("JSON deserialization failed")
        }
    }
    
    func process(dataObject: [String: Any], context: NSManagedObjectContext) {
        // query response object is on top
        // then we need to get the actual results object name.
        // results may contain several models or nested models
        for (apiCall, data) in dataObject {
            switch apiCall {
            case Constants.SubSonicAPI.Results.SongsByGenre,
                 Constants.SubSonicAPI.Results.RandomSongs:
                let dataDict = data as! [String: Any]
                let items = dataDict[Constants.SubSonicAPI.Results.Song] as! [[String: Any]]
                let _ = TrackMO.populate(fromArray: items, context: context)
            case Constants.SubSonicAPI.Results.Albums:
                let dataDict = data as! [String: Any]
                let items = dataDict[Constants.SubSonicAPI.Results.Album] as! [[String: Any]]
                let _ = AlbumMO.populate(fromArray: items, context: context)
            case Constants.SubSonicAPI.Results.Artists:
                let dataDict = data as! [String: Any]
                let items = dataDict[Constants.SubSonicAPI.Results.Index] as! [[String: Any]]
                let _ = ArtistMO.populate(fromArray: items, context: context)
            case Constants.SubSonicAPI.Results.Artist:
                let dataDict = data as! [String: Any]
                let _ = ArtistMO.populate(fromDict: dataDict, context: context)
            case Constants.SubSonicAPI.Results.Playlists:
                let dataDict = data as! [String: Any]
                let items = dataDict[Constants.SubSonicAPI.Results.Song] as! [[String: Any]]
                let _ = PlaylistMO.populate(fromArray: items, context: context)
            case Constants.SubSonicAPI.Results.Playlist:
                let dataDict = data as! [String: Any]
                let _ = PlaylistMO.populate(fromDict: dataDict, context: context)
            // Special case for search and starred
            case Constants.SubSonicAPI.Results.Starred,
                 Constants.SubSonicAPI.Results.Search:
                let foundData = data as! [String: Any]
                for (item, _) in foundData {
                    // we need to handle getting objects or lists
                    switch item {
                    default:
                        print(item)
                    }
                }
                
            default:
                print(apiCall)
            }
        }
    }

}
