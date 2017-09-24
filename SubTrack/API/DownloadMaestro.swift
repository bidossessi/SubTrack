//
//  DataMonitor.swift
//  SubMaestro
//
//  Created by Stanislas Sodonon on 6/17/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa

protocol DownloadMaestro: class {
//    var storage: FileMaestro { get }
//    var downloadQueue: QueueMaestro { get set }
//    var activeQueueMap: [URL: Download] { get set }
    var currentSession: URLSession? { get set }
    var session: URLSession { get }
    static var shared: DownloadMaestro { get }
    func subSonicMaestro(_ maestro: SubSonicMaestro, enqueueUrl url: URL, forDownloadable item: String)
    func subSonicMaestro(_ maestro: SubSonicMaestro, enqueueUrlMap map: [URL: String])
    func pauseDownload(For item: String)
    func resumeDownload(For item: String)
    func cancelDownload(For item: String)
    func startNext(_ from: String)
}

//extension DownloadMaestro {
//    
//    func makeDownload(url: URL, String: String) -> Download? {
//        if storage.fileExists(item: String) == true {
//            print("File already exists!!!")
//            return nil
//        }
//        let task = self.session.downloadTask(with: url)
//        return Download(item: String, url: url, task: task)
//    }
//    
//    func subSonicMaestro(_ maestro: SubSonicMaestro, enqueueUrl url: URL, forDownloadable item: String) {
//        guard let download = self.makeDownload(url: url, String: item) else { return }
//        self.downloadQueue.enqueue(aDownload: download)
//    }
//
//    func subSonicMaestro(_ maestro: SubSonicMaestro, enqueueUrlMap map: [URL: String]) {
//        for (url, item) in map {
//            self.subSonicMaestro(maestro, enqueueUrl: url, forDownloadable: item)
//        }
//    }
//
//    func startNext(_ from: String = "Unknown") {
//        guard let nextDownload: Download = self.downloadQueue.next() else {
//            print("nothing found in queue")
//            self.currentSession = nil
//            return
//        }
//        self.activeQueueMap.updateValue(nextDownload, forKey: nextDownload.url)
//        nextDownload.task.resume()
//    }
//    
//    func pauseDownload(For item: String) {}
//    func resumeDownload(For item: String) {}
//    func cancelDownload(For item: String) {}
//}

