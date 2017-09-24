//
//  SubSonicRemoteApi.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 6/16/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Foundation
import CoreData

struct SubSonicConfig {
    let serverUrl: String
    let username: String
    let password: String
}


protocol SubSonicMaestro: class {
    var container: NSPersistentContainer { get }
    var config: SubSonicConfig { get }
    var dataDelegate: HTTPMaestro  { get }
//    var mediaDownloadDelegate: DownloadMaestro  { get }
//    var artDownloadDelegate: DownloadMaestro  { get }
    var urlDelegate: URLMaestro  { get }
    func enqueueDownload(playable: String)
    func enqueueDownload(playables: [String])
    func enqueueDownload(cover: String)
    func enqueueDownload(covers: [String])

}

class RemoteBackend: SubSonicMaestro {
    let container: NSPersistentContainer
    let config: SubSonicConfig
    let defaults: UserDefaults = UserDefaults.standard
    let dataDelegate: HTTPMaestro = DataMonitor.shared
    let urlDelegate: URLMaestro = URLMonitor.shared

    // TODO: Backend should be initialized with it's configs
    init(config: SubSonicConfig, container: NSPersistentContainer) {
        self.config = config
        self.container = container
        print("RemoteBackend started")
    }
    
    //TODO: This must die!!!
    convenience init(withContainer container: NSPersistentContainer) {
        let config = SubSonicConfig(serverUrl: "http://192.168.1.100:8989",
                                    username: "bidossessi",
                                    password: "kil234ler")
        self.init(config: config, container: container)
    }
    
    
    func api(endpoint: String, params: [String: String]) {
        let url = self.urlDelegate.subSonicMaestro(self, apiEndpoint: endpoint, queryParams: params)
        self.dataDelegate.subSonicMaestro(self, requestForURL: url, endpoint: endpoint, container: self.container)
    }
    
    func enqueueDownload(playable: String) {
        let _ = self.urlDelegate.subSonicMaestro(self, downloadUrlForMedia: playable)
//        self.mediaDownloadDelegate.subSonicMaestro(self, enqueueUrl: url, forDownloadable: playable)
    }
        
    func enqueueDownload(playables: [String]) {
        var map: [URL: String] = [:]
        for item in playables {
            let url = self.urlDelegate.subSonicMaestro(self, downloadUrlForMedia: item)
            map.updateValue(item, forKey: url)
        }
//        self.mediaDownloadDelegate.subSonicMaestro(self, enqueueUrlMap: map)
    }

    
    func enqueueDownload(cover: String) {
        let _ = self.urlDelegate.subSonicMaestro(self, downloadUrlForCover: cover)
//        self.artDownloadDelegate.subSonicMaestro(self, enqueueUrl: url, forDownloadable: item)
    }
    
    func enqueueDownload(covers: [String]) {
        var map: [URL: String] = [:]
        for item in covers {
            let url = self.urlDelegate.subSonicMaestro(self, downloadUrlForCover: item)
            map.updateValue(item, forKey: url)
        }
//        self.artDownloadDelegate.subSonicMaestro(self, enqueueUrlMap: map)
    }
}
