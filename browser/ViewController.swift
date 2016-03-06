//
//  ViewController.swift
//  browser
//
//  Created by Alexander Manusovich on 3/6/16.
//  Copyright © 2016 Alexander Manusovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL (string: "http://192.168.1.79:8443")
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj)
        
        NSTimer.scheduledTimerWithTimeInterval(300, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    func update() {
        webView.reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

