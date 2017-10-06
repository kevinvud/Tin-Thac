//
//  BaiDocViewController.swift
//  Tin Thac
//
//  Created by PoGo on 9/21/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class BaiDocViewController: UIViewController {
    
     var baiDoc = ""

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let htmlCode = baiDoc
        navigationItem.title = "Bài Đọc & Thánh Vịnh"
        webView.loadHTMLString(htmlCode, baseURL: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
