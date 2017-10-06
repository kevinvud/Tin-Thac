//
//  ThanhCaViewController.swift
//  Tin Thac
//
//  Created by PoGo on 9/21/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import SafariServices

class ThanhCaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let thanhCaVN_URL = URL(string: "http://thanhcavietnam.net/ThanhCaVN/#Home")
    let tinmungMaria_URL = URL(string: "http://tinmungmedia.net/ThanhCaINDEX.htm")
    
    @IBOutlet weak var tableView: UITableView!
    
    let playlistArray = ["Thanhcavietnam.net","Tinmungmaria.net"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
            let safariVC = SFSafariViewController(url: thanhCaVN_URL!)
            present(safariVC, animated: true, completion: nil)
            
        }
        
        if indexPath.row == 1{
            let safariVC = SFSafariViewController(url: tinmungMaria_URL!)
            present(safariVC, animated: true, completion: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "thanhCaCell")
        cell.separatorInset = UIEdgeInsets.zero
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        cell.textLabel?.text = playlistArray[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.blue
        return cell
  
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "Thánh Ca"
 
    }


}
