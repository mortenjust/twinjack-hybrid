//
//  AppDelegate.swift
//  Twinjack-hybrid
//
//  Created by Morten Just Petersen on 9/5/16.
//  Copyright © 2016 Morten Just Petersen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let win = NSApplication.sharedApplication().windows.first!
        win.titlebarAppearsTransparent = true
        win.movableByWindowBackground = true
        win.styleMask = win.styleMask | NSFullSizeContentViewWindowMask;
        win.title = ""
        
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

