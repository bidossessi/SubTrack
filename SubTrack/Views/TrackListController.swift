//
//  SubTrackController.swift
//  SubMaestro
//
//  Created by Stanislas Sodonon on 6/18/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa

class TrackListController: NSViewController, SubTableViewController {
    
    var activeView: NSView?
    var canvas: NSView = NSView(frame: NSZeroRect)
    var placeholder: NSView
    var scrollView = NSScrollView(frame: NSZeroRect)
    var subDataView = NSTableView(frame: NSZeroRect)
    var dataController: NSArrayController
    
    init(_ dataController: NSArrayController, placeholder loadingView: NSView = PlaceHolder(text: "Tracks...")) {
        self.dataController = dataController
        self.placeholder = loadingView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.canvas
    }
    
    func makeTextColumn(_ identifier: NSUserInterfaceItemIdentifier, key: String, width: CGFloat = 200) -> NSTableColumn {
        
        let column = NSTableColumn(identifier: identifier)
        column.title = key.capitalized
        let sorter = NSSortDescriptor(key: key, ascending: false)
        column.sortDescriptorPrototype = sorter
        column.width = width
        return column
    }
    
    func makeIntColumn(_ identifier: NSUserInterfaceItemIdentifier, key: String) -> NSTableColumn {
        
        let column = NSTableColumn(identifier: identifier)
        column.headerCell.alignment = NSTextAlignment.right
        column.title = key.capitalized
        column.sizeToFit()
        let sorter = NSSortDescriptor(key: key, ascending: false)
        column.sortDescriptorPrototype = sorter
        return column
    }
    
    func makeSilentIntColumn(_ identifier: NSUserInterfaceItemIdentifier, key: String) -> NSTableColumn {
        let column = NSTableColumn(identifier: identifier)
        column.title = ""
        column.width = 50
        let sorter = NSSortDescriptor(key: key, ascending: false)
        column.sortDescriptorPrototype = sorter
        return column
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        var trackTableColumns: [NSTableColumn] = []
        trackTableColumns.append(
            self.makeSilentIntColumn(
                NSUserInterfaceItemIdentifier("track"), key: "track"))
        trackTableColumns.append(
            self.makeTextColumn(
                NSUserInterfaceItemIdentifier("title"), key: "title", width: 250))
        
        for column in trackTableColumns {
            self.subDataView.addTableColumn(column)
        }
        self.subDataView.delegate = self

        self.finalizeView()
        self.subDataView.bind(.content, to: self.dataController, withKeyPath: "arrangedObjects", options: nil)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
//        self.dataController.fetch(...)
    }

    override func viewWillDisappear() {
        
    }
}


extension TrackListController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let identifier = tableColumn?.identifier
        
        if let cell = tableView.makeView(withIdentifier: identifier!, owner: self) {
            return cell
        }
        return makeBoundTextField(property: identifier!.rawValue)
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat{
        return Constants.UI.TrackTableHeight
    }

}
