//
//  Storage.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 6/9/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa

protocol FileMaestro: class {
    func clearDownloadableCache()
    func clearArtCache()
    
    func fileExists(item: Downloadable) -> Bool
    
    func downloadMaestro(_ maestro: DownloadMaestro, getUrlFor item: Downloadable) -> URL?
    func downloadMaestro(_ maestro: DownloadMaestro, saveFile location: URL, forItem item: Downloadable)
    func playQueue(_ queue: PlayQueueMaestro, getUrlFor item: PlayableMedia) -> URL
}

class SubStorage: NSObject, FileMaestro {
    let localFileSystem = FileManager.default
    var musicRoot: NSString
    var coverRoot: NSString

    // Can't init is singleton
    private override init() {
        self.musicRoot = NSString(string: "~/SubMaestroMedia/Music").expandingTildeInPath as NSString
        self.coverRoot = NSString(string: "~/SubMaestroMedia/CoverArt").expandingTildeInPath as NSString
        super.init()
        print(self.musicRoot)
        print(self.coverRoot)
    }
    
    // MARK: Shared Instance
    
    static let shared = SubStorage()

    func getPathForItem(item: Downloadable) -> NSString {
        if item is PlayableMedia {
            let media = item as! PlayableMedia
            return self.musicRoot.appendingPathComponent(media.path) as NSString
        } else {
            return self.coverRoot.appendingPathComponent(item.id) as NSString
        }
    }
    
    func fileExists(item: Downloadable) -> Bool {
        let finalPath = getPathForItem(item: item)
        return localFileSystem.fileExists(atPath: finalPath as String)
    }
    
    func clearDownloadableCache() {}
    func clearArtCache() {}
    
    func playQueue(_ queue: PlayQueueMaestro, getUrlFor item: PlayableMedia) -> URL {
        let finalPath = getPathForItem(item: item)
        return URL(fileURLWithPath: finalPath as String)
    }
    
    func downloadMaestro(_ maestro: DownloadMaestro, getUrlFor item: Downloadable) -> URL? {
        let finalPath = getPathForItem(item: item)
        do {
            let pwd = finalPath.deletingLastPathComponent
            let pwdUrl = URL(fileURLWithPath: pwd)
            try localFileSystem.createDirectory(at: pwdUrl, withIntermediateDirectories: true, attributes: nil)
            
            return URL(fileURLWithPath: finalPath as String)
        } catch let error {
            print("FileMaestro: \(error.localizedDescription)")
            return nil
        }
    }
    
    func downloadMaestro(_ maestro: DownloadMaestro, saveFile location: URL, forItem item: Downloadable) {
        let destinationUrl = self.downloadMaestro(maestro, getUrlFor: item)
        print("about to move file to: \(String(describing: destinationUrl))")
        do {
            try localFileSystem.moveItem(at: location, to: destinationUrl!)
        } catch let error {
            print(error.localizedDescription)
        }

    }

}
