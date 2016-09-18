//
//  WindowDraggerView.swift
//  Twinjack-hybrid
//
//  Created by Morten Just Petersen on 9/6/16.
//  Copyright © 2016 Morten Just Petersen. All rights reserved.
//

import Cocoa

class WindowDraggerView: NSView {

    
    var initialLocation:NSPoint!
    
    override var mouseDownCanMoveWindow: Bool {
        get {
            return true;
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        initialLocation = theEvent.locationInWindow
        super.mouseDown(with: theEvent)
    }
    
    override func mouseDragged(with theEvent: NSEvent) {
        let w = NSApplication.shared().mainWindow!
        //let screenVisibleFrame = NSScreen.mainScreen()?.visibleFrame
        let windowFrame = w.frame
        let currentLocation = theEvent.locationInWindow
        var newOrigin = windowFrame.origin
        
        newOrigin.x += (currentLocation.x - initialLocation.x)
        newOrigin.y += (currentLocation.y - initialLocation.y)
        
        w.setFrameOrigin(newOrigin)
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Swift.print("setting up the dragview")
        wantsLayer = true
        //  layer?.backgroundColor = NSColor.redColor().CGColor
        alphaValue = 0.0
        
        
        
    }

    
}
