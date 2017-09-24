//
//  URLMaestro.swift
//  SubMaestro
//
//  Created by Stanislas Sodonon on 6/18/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa

protocol URLMaestro: class {
    var defaults: UserDefaults { get }
    static var shared: URLMaestro { get }
    func subSonicMaestro(_ api: SubSonicMaestro, apiEndpoint endpoint: String, queryParams params: [String: String]) -> URL
    func subSonicMaestro(_ api: SubSonicMaestro, downloadUrlForMedia id: String) -> URL
    func subSonicMaestro(_ api: SubSonicMaestro, downloadUrlForCover id: String) -> URL
}



class URLMonitor: URLMaestro {

    // My job is to return properly formatted URLs
    static let shared: URLMaestro = URLMonitor()

    let defaults: UserDefaults = UserDefaults.standard
    
    private init() {
        print("URLMonitor started")
    }

    
    private func getUrlString(_ api: SubSonicMaestro, endpoint: String) -> String {
        let serverUrl = api.config.serverUrl
        return "\(serverUrl)/rest/\(endpoint).view"
    }
    
    private func buildURL(_ api: SubSonicMaestro, endpoint: String, params: [String: String]) -> URL {
        let baseUrl: String = self.getUrlString(api, endpoint: endpoint)
        
        let defaultParams: [String: String] = [
            "u": api.config.username,
            "p": api.config.password,
            "c": Constants.SubSonicInfo.apiName,
            "v": Constants.SubSonicInfo.apiVersion,
            // Ideally, this should come from config (advanced)
            "f": Constants.SubSonicInfo.apiFormat
        ]
        var queryParams: [String: String] = [:]
        for (key, value) in defaultParams {
            queryParams[key] = value
        }
        for (key, value) in params {
            queryParams[key] = value
        }
        
        let parameterString = queryParams.stringFromHttpParameters()
        let finalString = "\(baseUrl)?\(parameterString)"
        return URL(string: finalString)!
    }

    
    func subSonicMaestro(_ api: SubSonicMaestro, apiEndpoint endpoint: String, queryParams params: [String: String]) -> URL {
        return buildURL(api, endpoint: endpoint, params: params)
    }
    
    func subSonicMaestro(_ api: SubSonicMaestro, downloadUrlForMedia id: String) -> URL {
        return buildURL(api, endpoint: "download", params: ["id": id])
    }

    func subSonicMaestro(_ api: SubSonicMaestro, downloadUrlForCover id: String) -> URL {
        return buildURL(api, endpoint: "getCoverArt", params: ["id": id])
    }


}
