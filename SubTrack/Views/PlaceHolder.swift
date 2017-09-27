//
//  PlaceHolder.swift
//  SubMaestro
//
//  Created by Stanislas Sodonon on 6/18/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa

class PlaceHolder: NSView {

    init(text: String = "Placeholder") {
        super.init(frame: NSZeroRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor

        let textField = NSTextField()
        textField.font = NSFont.boldSystemFont(ofSize: 24)
        textField.textColor = NSColor.disabledControlTextColor
        textField.alignment = NSTextAlignment.center
        textField.isBordered = false
        textField.drawsBackground = false
        textField.isEditable = false


        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        textField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.stringValue = text
        textField.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
}
