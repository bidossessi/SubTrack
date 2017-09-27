//
//  JSONParserTest.swift
//  SubTrackTests
//
//  Created by Stanislas Sodonon on 9/27/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import XCTest
@testable import SubTrack

class JSONParserTest: XCTestCase {
    
    let parser: ParserMaestro = JSONRequestParser.shared
    let notif = NotificationCenter.default
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAlbumList() {
        let container = makeTestContainer(name: "SubTrack")
        container.viewContext.automaticallyMergesChangesFromParent = true
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "albumlist", withExtension: "json") else {
            XCTFail("Missing albumlist.json")
            return
        }
        do {
            let json = try Data(contentsOf: url)
            guard let parsedJson = try? self.parser.parse(data: json) else {
                XCTFail("Parsing failed")
                return
            }
            do {
                try self.parser.persist(response: parsedJson, container: container)
            } catch {
                XCTFail("Failed to persist data: \(error)")
            }
            // MARK - fetch albums from store
            let albumsFetch: NSFetchRequest<AlbumMO> = AlbumMO.fetchRequest()
            
            func syncWhenReady(_ : Notification){
                do {
                    let fetchedAlbumsCount = try container.viewContext.count(for: albumsFetch)
                    let albumResponse = parsedJson["albumList2"] as! [String: Any]
                    let albumList = albumResponse["album"] as! [[String: Any]]
                    print("Got \(albumList.count) albums")
                    XCTAssert(albumList.count == fetchedAlbumsCount)
                } catch {
                    XCTFail("Failed to fetch albums: \(error)")
                }
            }
            
            notif.addObserver(forName: TestConstants.backgroundSaveComplete,
                              object: nil,
                              queue: nil,
                              using: syncWhenReady)
            
            
        } catch {
            XCTFail("Couldn't load data")
        }

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
