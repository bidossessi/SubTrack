//
//  CellMaker.swift
//  SubMaestro
//
//  Created by Stanislas Sodonon on 7/3/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa


func makeBoundTextField(property: String) -> NSView {
    let cell = NSTableCellView()
    let text = CleanTextField()
    text.bind(.value, to: cell, withKeyPath: "objectValue.\(property)", options: nil)
    cell.textField = text
    cell.addSubview(text)
    return cell

}

func makeField(duration: NSNumber) -> NSView {
    let cell = DurationField()
    cell.formatShort(duration: duration.intValue)
    return cell
}


func makeField(value: String) -> NSView {
    let cell = CleanTextField()
    cell.stringValue = value
    return cell
}

func makeField(number: NSNumber) -> NSView {
    let cell = CleanIntField()
    cell.integerValue = number.intValue
    return cell
}


func makeCell(track: TrackMO, identifier: NSUserInterfaceItemIdentifier) -> NSView? {
    switch identifier.rawValue {
    case "title":
        return makeField(value: track.title!)
    case "album":
        return makeField(value: track.album!)
    case "genre":
        return makeField(value: track.genre!)
    case "artist":
        return makeField(value: track.artist!)
    case "track":
        return makeField(number: NSNumber(value: track.track))
    case "duration":
        return makeField(duration: NSNumber(value: track.duration))
    default:
        return nil
    }
}


func makeCell(genre: GenreMO, identifier: String) -> NSView? {
    let cell = LabelTextField()
    cell.textField.stringValue = genre.name!.capitalized
    cell.pillField.integerValue = Int(genre.songCount)
    cell.sizeToFit()
    return cell
}

func makeCell(index: ArtistIndexMO) -> NSView {
    let cell = SectionHeaderField()
    cell.textField.stringValue = index.name!
    cell.sizeToFit()
    return cell
}

func makeCell(artist: ArtistMO) -> NSView {
    let cell = LabelTextField()
    cell.textField.stringValue = artist.name!
    if Int(artist.albumCount) > 0 {
        cell.pillField.integerValue = Int(artist.albumCount)
    }
    cell.sizeToFit()
    return cell
    
}

func makeCell(artistOrIndex: AnyObject, identifier: String) -> NSView? {
    guard let artist = artistOrIndex as? ArtistMO else {
        return makeCell(index: artistOrIndex as! ArtistIndexMO)
    }
    return makeCell(artist: artist)
}


func makeCell(playlist: PlaylistMO, identifier: String) -> NSView? {
    let cell = LabelTextField()
    cell.textField.stringValue = playlist.name!.capitalized
    cell.sizeToFit()
    return cell
}

