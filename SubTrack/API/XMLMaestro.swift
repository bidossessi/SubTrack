//
//  RequestParser.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 6/9/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa

protocol SubXMLDelegate: class {
    var completionCallback: ([String: Any]) -> Void { get }
}

class RequestParser: NSObject, SubXMLDelegate, XMLParserDelegate {
    
    var completionCallback: ([String : Any]) -> Void
    var currentString: String?
    var lastTag: String = ""
    var tracks: [TrackMO] = []
    var genres: [GenreMO] = []
    var playlists: [PlaylistMO] = []
    var artists: [ArtistMO] = []
    var artistIndexes: [ArtistIndexMO] = []
    var albums: [AlbumMO] = []
    
    var processIndex = 0
    
    init(completionCallback: @escaping ([String: Any]) -> Void) {
        self.completionCallback = completionCallback
    }
    
    
    func handleLine(artist: [String: String]) {
        // if we're at processIndex 1, then this is a getArtist query
        let item = ArtistMO(attrs: artist)
        self.artists.append(item)
    }
    
    func handleLine(album: [String: String]) {
        let item = Album(attrs: album)
        self.albums.append(item)
    }

    func handleLine(playlist: [String: String]) {
        let item = Playlist(attrs: playlist)
        self.playlists.append(item)
    }
    
    func handleLine(genre: [String: String]) {
        self.currentString = ""
        let item = Genre(attrs: genre)
        self.genres.append(item)
    }
    
    func handleLine(index: [String: String]) {
        let item = ArtistIndex(attrs: index)
        self.artistIndexes.append(item)
    }
    
    func handleLine(song: [String: String]) {
        let item = Track(attrs: song)
        self.tracks.append(item)
    }
    func handleLine(entry: [String: String]) {
        if entry["type"] == "music" {
            let item = TrackMO(attrs: entry)
            self.tracks.append(item)
        }
    }

    
    // Document start
    func parserDidStartDocument(_ parser: XMLParser) {
        print("started document")
    }
    
    //tag Attributes
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "subsonic-response":
            // Check the response
            do {
                try subsonicValidate(status: attributeDict[Constants.SubSonicInfo.RequestStatusAttr] as! String)
                try subsonicValidate(version: attributeDict[Constants.SubSonicInfo.APIVersionAttr] as! String)
            } catch {
                parser.abortParsing()
                return
            }
        case "song":
            self.handleLine(song: attributeDict)
        case "album":
            self.handleLine(album: attributeDict)
        case "artist":
            self.handleLine(artist: attributeDict)
        case "playlist":
            self.handleLine(playlist: attributeDict)
        case "index":
            self.handleLine(index: attributeDict)
        case "entry":
            self.handleLine(entry: attributeDict)
        case "genre":
            self.handleLine(genre: attributeDict)
        default:
            print(elementName)
        }
        self.processIndex += 1
    }
    
    // tag content
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        self.currentString? += string 
    }
    
    // tag end
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        
        switch elementName {
        case "index":
            let index = self.artistIndexes.last!
            index.artists = self.artists
            self.artists = []
        case "genre":
            let genre = self.genres.last!
            genre.title = self.currentString!
        default:
            break
        }
        self.lastTag = elementName
        self.currentString = nil
    }

    // Document end
    func parserDidEndDocument(_ parser: XMLParser) {
        self.notifyEndParsing()
    }
}
