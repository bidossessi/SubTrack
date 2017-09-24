//
//  DataMonitor.swift
//  SubMaestro
//
//  Created by Stanislas Sodonon on 6/17/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa



protocol HTTPMaestro: class, URLSessionDelegate {
    static var shared: HTTPMaestro { get }
    var jsonParserDelegate: ParserMaestro { get }
//    var xmlParserDelegate: ParserMaestro { get }
    var taskDataMap: [URLSessionTask: Data] { get set }
    
    func subSonicMaestro(_ api: SubSonicMaestro,
                         requestForURL url: URL,
                         endpoint: String,
                         container: NSPersistentContainer)
}

class DataMonitor: NSObject, HTTPMaestro {
    var taskDataMap: [URLSessionTask : Data] = [:]
    var taskContainerMap: [URLSessionTask : NSPersistentContainer] = [:]
    let jsonParserDelegate: ParserMaestro = JSONRequestParser.shared
//    let xmlParserDelegate: ParserMaestro = XMLRequestParser.shared

    static let shared: HTTPMaestro = DataMonitor()

    
    override private init() {
        super.init()
        print("DataMonitor started")
    }

    
    var session : URLSession {
        get {
            let config = URLSessionConfiguration.default
            // Get this from settings
            config.allowsCellularAccess = true
            config.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
        }
    }


    func subSonicMaestro(_ api: SubSonicMaestro,
                         requestForURL url: URL,
                         endpoint: String,
                         container: NSPersistentContainer) {
        let task = self.session.dataTask(with: url)
        self.taskContainerMap[task] = container
        task.resume()
    }
    

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?){
        if error != nil {
            fatalError("HTTP error: \(error!)")
        }
        else{
            print("HTTPMaestro Request - complete!")
            let data = self.taskDataMap.removeValue(forKey: task)!
            let container = self.taskContainerMap.removeValue(forKey: task)!
            // Ideally, according to config `format`, we would choose a parser.
            // But we stick with JSON for now
            self.jsonParserDelegate.queryMaestro(self, requestData: data, container: container)
//            self.xmlParserDelegate.queryMaestro(self, requestData: data, container: container)
        }
    }
}

extension DataMonitor: URLSessionDataDelegate {
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        guard let sourceURL = dataTask.originalRequest?.url else { return }
        print("first response received: \(sourceURL)")
        self.taskDataMap.updateValue(Data(), forKey: dataTask)
        completionHandler(URLSession.ResponseDisposition.allow)
    }
    
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        var existing: Data = taskDataMap[dataTask] ?? Data()
        existing.append(data)
        self.taskDataMap.updateValue(existing, forKey: dataTask)
    }
}

