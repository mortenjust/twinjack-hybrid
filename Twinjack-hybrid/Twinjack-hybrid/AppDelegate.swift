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
    
    @IBOutlet weak var statusItemMenu: NSMenu!
    @IBOutlet weak var win: NSWindow!
    var statusItem : NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let win = NSApplication.shared().windows.first!
        win.titlebarAppearsTransparent = true
        win.isMovableByWindowBackground = true
        // win.styleMask = win.styleMask | NSFullSizeContentViewWindowMask;
        win.styleMask = [win.styleMask, NSFullSizeContentViewWindowMask]
        win.title = ""
        
        
        statusItem = NSStatusBar.system().statusItem(withLength: -1)
        
        statusItem.image = NSImage(named: "twinjackstatus")
        statusItem.alternateImage = NSImage(named: "twinjackstatus-alternate")
        //statusItem.action = #selector(showSelected(sender:))
//        statusItem.menu = statusItemMenu
        
        let menu = NSMenu(title: "hehe")
        
        menu.addItem(NSMenuItem(title: "Show", action: #selector(showSelected(sender:)), keyEquivalent: ""))
        
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitSelected(sender:)), keyEquivalent: ""))
        
        statusItem.menu = menu
        
    }
    
    func quitSelected(sender:AnyObject){
        NSApp.terminate(nil)
    }

    @IBAction func showSelected(sender: AnyObject) {
           makeWindowActive()
    }
    
    func makeWindowActive(){
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

