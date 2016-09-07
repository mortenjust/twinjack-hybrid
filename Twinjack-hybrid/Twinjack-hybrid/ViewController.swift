//
//  ViewController.swift
//  Twinjack-hybrid
//
//  Created by Morten Just Petersen on 9/5/16.
//  Copyright © 2016 Morten Just Petersen. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, NSTextFieldDelegate {
    
    var webView = WKWebView()
    var centerReceiver = NSDistributedNotificationCenter()
    
    @IBOutlet weak var windowDraggerView: WindowDraggerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.autoresizesSubviews = true
        self.view.addSubview(webView)
        webView.frame = self.view.frame        
        webView.autoresizingMask = [.ViewHeightSizable, .ViewWidthSizable]
        webView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(webView)
        view.addSubview(windowDraggerView)
        
        loadWebUI()
        startSpotifyObserver()
    }

    func loadWebUI(){
        let ud = NSUserDefaults.standardUserDefaults()
        let useLocalhost = ud.boolForKey("useLocalHost")
        
        var u = "https://handy-balancer-91514.firebaseapp.com/admin"
        
        if useLocalhost {
            print("using local host")
            u = "http://localhost:3000/admin"
        } else {
            print("using handybalancer")
        }
        
        print("load")
        
        let r = NSURLRequest(URL: NSURL(string: u)!)
        webView.loadRequest(r)
    }
    
    func startSpotifyObserver(){
        self.centerReceiver.addObserverForName("com.spotify.client.PlaybackStateChanged", object: nil, queue: nil) { (note) -> Void in
                print("got spotify event")
                let info = note.userInfo!
                let state = info["Player State"] as! String

                switch state{
                case "Paused":
                    print("paused")
                case "Playing":
                    let track = Track(spotifyInfo: info)
                    print("started track:"+track.name)
                    self.play(track)
                default:
                    print("Spotify Not playing or paused")
                    self.pause()
            }
        }
    }
    
    func play(track:Track){
//        let js = "window.startSong('\(track.name)', '\(track.artist)', '\(track.album)')"
        let js = "window.startSong({track:\"\(track.name)\", artist:\"\(track.artist)\", album:\"\(track.album)\", position:\(track.position)})"
        print(js)
        webView.evaluateJavaScript(js) { (result, error) in
            print(result)
        }
    }
    
    func pause(){
        let js = "window.pauseSong()"
        print(js)
        webView.evaluateJavaScript(js) { (result, error) in
            print(result)
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func webView(webView: WebView!, decidePolicyForNewWindowAction actionInformation: [NSObject : AnyObject]!, request: NSURLRequest!, newFrameName frameName: String!, decisionListener listener: WebPolicyDecisionListener!) {
        print("\ndecidePolicyForNewWindowAction: \(request.URL?.absoluteString)")
        listener.use()
    }

}

