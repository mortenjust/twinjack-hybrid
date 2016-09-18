//
//  ViewController.swift
//  Twinjack-hybrid
//
//  Created by Morten Just Petersen on 9/5/16.
//  Copyright © 2016 Morten Just Petersen. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, NSTextFieldDelegate, WKNavigationDelegate, WKUIDelegate {
    
    var webView = WKWebView()
    var centerReceiver = DistributedNotificationCenter()
    
    @IBOutlet weak var windowDraggerView: WindowDraggerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.autoresizesSubviews = true
        self.view.addSubview(webView)
        webView.frame = self.view.frame        
        webView.autoresizingMask = [.viewHeightSizable, .viewWidthSizable]
        webView.translatesAutoresizingMaskIntoConstraints = true
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.wantsLayer = true
        webView.enclosingScrollView?.wantsLayer = true
        webView.enclosingScrollView?.backgroundColor = NSColor.clear
        
        view.addSubview(webView)
        view.addSubview(windowDraggerView)
        
        
        loadWebUI()
        startSpotifyObserver()
    }

    func loadWebUI(){
        let ud = UserDefaults.standard
        let useLocalhost = ud.bool(forKey: "useLocalHost")
        
        var version = "unknown"
        if let v = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            version = v
        }
        var u = "https://handy-balancer-91514.firebaseapp.com/admin?version=\(version)"
        print("url is \(u)")
        
        if useLocalhost {
            print("using local host")
            u = "http://localhost:3000/admin"
        } else {
            print("using handybalancer")
        }
        
        print("load")
        
        let r = URLRequest(url: URL(string: u)!)
        webView.load(r)
        
        
    }
    
    func startSpotifyObserver(){
        self.centerReceiver.addObserver(forName: NSNotification.Name(rawValue: "com.spotify.client.PlaybackStateChanged"), object: nil, queue: nil) { (note) -> Void in
                print("got spotify event")
                let info = (note as NSNotification).userInfo!
                let state = info["Player State"] as! String

                switch state{
                case "Paused":
                    print("paused")
                    self.pause()
                case "Playing":
                    let track = Track(spotifyInfo: info as [NSObject : AnyObject])
                    print("started track:"+track.name)
                    self.play(track)
                default:
                    print("Spotify Not playing or paused")
                    
            }
        }
    }
    
    func play(_ track:Track){
//        let js = "window.startSong('\(track.name)', '\(track.artist)', '\(track.album)')"
        let js = "window.startSong({track:\"\(track.name)\", artist:\"\(track.artist)\", album:\"\(track.album)\", position:\(track.position!)})"
        print(js)
        webView.evaluateJavaScript(js) { (result, error) in
            print(result)
            print(error)
        }
    }
    
    func pause(){
        let js = "window.pauseSong()"
        print(js)
        webView.evaluateJavaScript(js) { (result, error) in
            print(result)
            print(error?.localizedDescription)
        }
    }

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finished navigating")
        
        
    }
    
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        print("createwebview with")
        
        let url = navigationAction.request.url!
        NSWorkspace.shared().open(url)
        
        return nil
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("deciding policy")
        decisionHandler(.allow)

    }
    
    
}

