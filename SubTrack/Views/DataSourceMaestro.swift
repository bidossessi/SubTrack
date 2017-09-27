//
//  BaseController.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 6/13/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa

protocol DataSourceMaestro: class {}

protocol SubTableDataSource: class, NSTableViewDataSource, DataSourceMaestro {}

protocol SubOutlineDataSource: class, NSOutlineViewDataSource, DataSourceMaestro {}

protocol SubCollectionDataSource: class, NSCollectionViewDataSource, DataSourceMaestro {}
