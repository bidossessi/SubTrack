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

    func queryMaestro(_ api: HTTPMaestro, requestData data: Data, container: NSPersistentContainer) {
        
        //
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            
            guard let response = json?[Constants.SubSonicInfo.apiResponse] as? [String: Any] else {
                fatalError("Invalid SubSonic response")
            }
            // Check the response
            try? self.validate(status: response[Constants.SubSonicInfo.RequestStatusAttr] as! String)
            try? self.validate(version: response[Constants.SubSonicInfo.APIVersionAttr] as! String)
            

            container.performBackgroundTask() { (context) in
                // Do the work
                self.processData(json: response, context: context)
                // Save changes
                do {
                    try context.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
            }
            
        } else {
            fatalError("JSON deserialization failed")
        }
    }
}

extension JSONRequestParser {
    func processData(json: [String: Any], context: NSManagedObjectContext) {
        // query response object is on top
        // then we need to get the actual results object name.
        // results may contain several models or nested models
        for (apiCall, data) in json {
            let jsonArray = data as! [String: Any]
            switch apiCall {
            case Constants.SubSonicAPI.Results.SongsByGenre,
                 Constants.SubSonicAPI.Results.RandomSongs:
                for item in jsonArray[Constants.SubSonicAPI.Results.Song] as! [[String: Any]]{
                    self.createObject(track: item, context: context)
                }
            case Constants.SubSonicAPI.Results.Albums:
                for item in jsonArray[Constants.SubSonicAPI.Results.Album] as! [[String: Any]] {
                    self.createObject(album: item, context: context)
                }
            case Constants.SubSonicAPI.Results.Artists:
                for index in jsonArray["index"] as! [[String: Any]] {
                    self.createObject(index: index, context: context)
                }
            case Constants.SubSonicAPI.Results.Artist:
                self.createObject(artist: jsonArray, context: context)
            case Constants.SubSonicAPI.Results.Playlists:
                for item in jsonArray[Constants.SubSonicAPI.Results.Playlist] as! [[String: Any]] {
                    self.createObject(playlist: item, context: context)
                }
            case Constants.SubSonicAPI.Results.Playlist:
                self.createObject(playlist: jsonArray, context: context)
            default:
                print(apiCall)
            }
        }
    }
}
