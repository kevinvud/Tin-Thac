//
//  KinhThanhViewController.swift
//  Tin Thac
//
//  Created by PoGo on 9/18/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class KinhThanhViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let kinhThanhData = KinhThanhData()
    
    var arrayKinhThanh = [String]()
    
    var filterKinhThanh = [String]()
    
    var arrayKinhThanhValue = [String]()
    
    var searchMode = false
    
    var kinhThanhTitleSendToSegue = ""
    
    var kinhThanhValueToSegue = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
        navigationItem.title = "Kinh Thánh"
        
        
        
        for name in kinhThanhData.kinhThanhLibrary.keys {

            arrayKinhThanh.append(name)
            
            
        }
        arrayKinhThanh = arrayKinhThanh.sorted(by: {$0 < $1 })
        
        //tableView.tableFooterView = UIView()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchMode{
            return filterKinhThanh.count
        }
        return arrayKinhThanh.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "KinhThanhCell")
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        if searchMode{
            
             cell.textLabel?.text = filterKinhThanh[indexPath.row]
        } else{
            
    
        cell.textLabel?.text = arrayKinhThanh[indexPath.row]

        
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        if searchMode{
            let value = filterKinhThanh[indexPath.row]
            self.kinhThanhTitleSendToSegue = value
            let kinhThanh = kinhThanhData.kinhThanhLibrary["\(value)"]
            self.kinhThanhValueToSegue = kinhThanh!
            performSegue(withIdentifier: "docKinhThanhSegue", sender: self)
            
        } else{
            let value = arrayKinhThanh[indexPath.row]
            self.kinhThanhTitleSendToSegue = value
            let kinhThanh = kinhThanhData.kinhThanhLibrary["\(value)"]
            self.kinhThanhValueToSegue = kinhThanh!
            performSegue(withIdentifier: "docKinhThanhSegue", sender: self)
         
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let KTviewController = segue.destination as? KinhThanhDisPlayViewController{
            KTviewController.kinhThanhShow = kinhThanhValueToSegue
            KTviewController.kinhThanhTitle = kinhThanhTitleSendToSegue
            
            let backItem = UIBarButtonItem()
            backItem.title = " "
            navigationItem.backBarButtonItem = backItem
            
        }

    }
    
   @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            searchMode = false
            //view.endEditing(true)
            tableView.reloadData()
            
        } else {
            searchMode = true
            let searchText = searchBar.text!
            filterKinhThanh = arrayKinhThanh.filter({ (array:String) -> Bool in
                if array.range(of: searchText) != nil{
                    print(array)
                    return true
                } else{
                    print("false\(array)")
                    return false
                }
            })
            tableView.reloadData()
            
        }
        
        
    }
    

}
