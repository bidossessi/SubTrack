//
//  BaseController.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 6/13/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa

protocol ControllerMaestro: class {
    var activeView: NSView? {get set}
    var canvas: NSView { get set}
    var placeholder: NSView { get set}
    func switchTo(new: NSView)
}

extension ControllerMaestro {

    func layoutChild(view: NSView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.canvas.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.canvas.bottomAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.canvas.rightAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.canvas.leftAnchor).isActive = true
        
    }
    
    
    func switchTo(new: NSView) {
        if new == self.activeView { return }
        new.frame = self.canvas.bounds
        if self.activeView != nil {
            self.canvas.replaceSubview((self.activeView)!, with: new)
        } else {
            self.canvas.addSubview(new)
        }
        self.layoutChild(view: new)
        self.activeView = new
    }
    
}
