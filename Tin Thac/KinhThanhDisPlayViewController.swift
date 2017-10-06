//
//  KinhThanhDisPlayViewController.swift
//  Tin Thac
//
//  Created by PoGo on 9/19/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class KinhThanhDisPlayViewController: UIViewController {

    
    @IBOutlet weak var kinhThanhTextView: UITextView!

    @IBOutlet weak var kinhThanhTitleLabel: UILabel!
    
    var kinhThanhShow = ""
    
    var kinhThanhTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navController = navigationController!
        let logo = UIImage(named: "bible.png")
        let imageView = UIImageView(image: logo)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        
        
        let bannerX = bannerWidth / 2 - logo!.size.width / 2
        
        
        let bannerY = bannerHeight / 2 - logo!.size.height / 2
        
        
      
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth/2, height: bannerHeight/2)
        imageView.contentMode = .scaleAspectFit

        navigationItem.titleView = imageView
        
        kinhThanhTextView.text = kinhThanhShow
        
        kinhThanhTitleLabel.text = kinhThanhTitle
        
       
        // Do any additional setup after loading the view.
    }
    
    
    //Make sure text display on top left hand conner
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //kinhThanhLabel.sizeToFit()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
