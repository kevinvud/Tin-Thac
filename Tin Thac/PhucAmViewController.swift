//
//  ViewController.swift
//  Tin Thac
//
//  Created by PoGo on 9/18/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Alamofire

class PhucAmViewController: UIViewController {
    
    var phucAm = ""
   
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let htmlCode = phucAm
            print(htmlCode)
            navigationItem.title = "Phúc Âm"
            webView.loadHTMLString(htmlCode, baseURL: nil)

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

