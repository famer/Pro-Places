//
//  HelpViewController.swift
//  Places
//
//  Created by Тимур Татаршаов on 08.01.15.
//  Copyright (c) 2015 Timur Tatarshaov. All rights reserved.
//

import Foundation

class HelpViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.hidesBarsOnTap = true
        var url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("documentation", ofType: "pdf")!)
        var request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
    }
    
}