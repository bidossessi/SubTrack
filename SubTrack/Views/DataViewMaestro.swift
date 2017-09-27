//
//  BaseContainerController.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 6/13/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa

protocol DataViewMaestro: class, ControllerMaestro {
    var scrollView: NSScrollView { get set }
}

protocol SubTableViewController: class, DataViewMaestro {
    var subDataView: NSTableView { get set }
}

extension SubTableViewController {
    func finalizeView() {
        self.scrollView.documentView = self.subDataView
        self.scrollView.hasVerticalScroller = true
        self.subDataView.usesAlternatingRowBackgroundColors = true
        self.canvas.wantsLayer = true
        print("\(self)  Loaded")
    }

}


protocol SubOutlineViewController: class,  DataViewMaestro {
    var subDataView: NSOutlineView { get set }
}

extension SubOutlineViewController {
    func finalizeView() {
        let id = NSUserInterfaceItemIdentifier("header")
        let column = NSTableColumn(identifier: id)
        self.scrollView.documentView = self.subDataView
        self.scrollView.hasVerticalScroller = true
                
        self.subDataView.rowSizeStyle = NSTableView.RowSizeStyle.medium
        self.subDataView.addTableColumn(column)
        self.subDataView.outlineTableColumn = column
        self.subDataView.headerView = nil
        self.canvas.wantsLayer = true
        
        print("\(self)  Loaded")
    }
    
}


protocol SubCollectionViewController: class, DataViewMaestro {
    var subDataView: NSCollectionView { get set }
}


extension SubCollectionViewController {
    func finalizeView() {
        self.scrollView.documentView = self.subDataView
        self.scrollView.hasVerticalScroller = true
        self.canvas.wantsLayer = true
        print("\(self)  Loaded")
    }    
}
