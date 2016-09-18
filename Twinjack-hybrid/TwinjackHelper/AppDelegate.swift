//
//  AppDelegate.swift
//  TwinjackHelper
//
//  Created by Morten Just Petersen on 9/17/16.
//  Copyright © 2016 Morten Just Petersen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let bundlePath : String = NSBundle.mainBundle().bundlePath
        
        var pathComponents:NSArray = NSURL(fileURLWithPath: bundlePath).pathComponents!
        
        pathComponents = pathComponents.subarrayWithRange(NSMakeRange(0, pathComponents.count - 4))
        
        var path : NSString = NSString.pathWithComponents(pathComponents as! Array)
        print("launching \(path)")
        
        NSWorkspace.sharedWorkspace().launchApplication(path as String)
        
        // todo QUIT
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

