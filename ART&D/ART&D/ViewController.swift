//
//  ViewController.swift
//  ART&D
//
//  Created by Sam Decrock on 06/11/14.
//  Copyright (c) 2014 mix. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var webView: UIWebView!
    var ticker = 0
    let startUrl = NSURL(string: "http://demomix.local:3000")!
    let timeoutSeconds = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        webView = UIWebView(frame: UIScreen.mainScreen().applicationFrame)
        //        webView.scrollView.bounces = false
        (webView.subviews[0] as UIScrollView).bounces = false
        webView.loadRequest(NSURLRequest(URL: startUrl))
        
        
        webView.scalesPageToFit = true
        
        
        
        let tapRec = UITapGestureRecognizer(target: self, action:Selector("gestureHappened:"))
        let pinchRec = UIPinchGestureRecognizer(target: self, action:Selector("gestureHappened:"))
        let swipeRec = UISwipeGestureRecognizer(target: self, action:Selector("gestureHappened:"))
        let longPressRec = UILongPressGestureRecognizer(target: self, action:Selector("gestureHappened:"))
        let rotateRec = UIRotationGestureRecognizer(target: self, action:Selector("gestureHappened:"))
        let panRec = UIPanGestureRecognizer(target: self, action:Selector("gestureHappened:"))
        
        tapRec.delegate = self
        pinchRec.delegate = self
        swipeRec.delegate = self
        longPressRec.delegate = self
        rotateRec.delegate = self
        panRec.delegate = self
        
        tapRec.numberOfTapsRequired = 1
        
        webView.addGestureRecognizer(tapRec)
        webView.addGestureRecognizer(swipeRec)
        webView.addGestureRecognizer(pinchRec)
        webView.addGestureRecognizer(longPressRec)
        webView.addGestureRecognizer(rotateRec)
        webView.addGestureRecognizer(panRec)

        
        self.view = webView
        
        let aSelector : Selector = "timer_tick"
        let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
    }
    
    func timer_tick(){
        ticker++
//        println("ticker: \(ticker)")
        
        if ticker > timeoutSeconds {
//            println("\(timeoutSeconds) seconds have passed since last tap.. refreshing to start page")
            webView.loadRequest(NSURLRequest(URL: startUrl))
//            println("resetting ticker")
            ticker = 0
        }
    }
    
    func gestureRecognizer(UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureHappened(recognizer: UITapGestureRecognizer) {
//        println("gestured detected. resetting ticker")
        ticker = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

