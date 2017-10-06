//
//  SuperMainViewController.swift
//  Tin Thac
//
//  Created by PoGo on 9/18/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices

class SuperMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var cellTitles = ["Bài Đọc và Thánh Vịnh", "Phúc Âm", "Bài Chia Sẻ Hôm Nay", "Kinh Thánh", "Thánh Ca", "Audio Books Về Chúa, Đức Mẹ, và More"]
    let baiGiangHomNay_URL = URL(string: "http://tinthac.net/index.php/nhat-ky-bai-giang/")
    let AUDIOBOOK_URL = URL(string: "http://tinmung.net/AudioBooks/TinmungAudiobooks/INDEX..htm")
    var insertPhucAmText = "<p style=\"margin: 4.5pt 0cm; text-align: justify;\"><b><span style=\"font-size:14.0pt;font-family:&quot;Times&quot;,&quot;serif&quot;;color:blue\">P"
    var insertBaiDocText = "Alleluia."
    var insertBaiDocTextAtBegin = "<p style=\"margin: 4.5pt 0cm; text-align: justify;\"><b><span style=\"font-size: 14.0pt;font-family:&quot;Times&quot;,&quot;serif&quot;;color:blue\">Bài Ðọc I:"
    var phucAmMessage = ""
    var baiDocMessage = ""
    
    var homNayPhucAmQuote = ""
    
    var todayDate = ""
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mainScreenDateLabel: UILabel!
    
    @IBOutlet weak var mainScreenImportantDate: UILabel!
    
    @IBOutlet weak var mainScreenQuoteLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        getTodayDateAndDateFromURL()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getTodayDateAndDateFromURL),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func getTodayDateAndDateFromURL(){
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let result = formatter.string(from: date)
        todayDate = result
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year
        
        let month = components.month
        
        let day = components.day
        
        mainScreenDateLabel.text = "Hôm nay, ngày \(day!) tháng \(month!), \(year!)"
        
        var message = ""
        var newMessage = ""
        
        
        let url = URL(string: "http://tinvuixuanloc.vn/LoiChuaHomNay_\(todayDate).aspx")
        
        Alamofire.request(url!).responseJSON { (response) in
            //            if let json = response.result.value {
            //                print("YES YES YES YES")
            //                print("JSON: \(json)") // serialized json response
            //            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                //print("Data: \(utf8Text)") // original server data as UTF8 string
                
                var stringSeparator = "<head id=\"ctl00_ctl00_Head1\"><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" /><title>\r\n\t"
                var stringSeparatorForPhucAm = "14.0pt;font-family:&quot;Times&quot;,&quot;serif&quot;;color:blue\">P"
                var stringSeparatorForBaiDoc = "14.0pt;font-family:&quot;Times&quot;,&quot;serif&quot;;color:blue\">Bài Ðọc I:"
                var stringSeparatorForHomNayQuote = "14.0pt;font-family:&quot;Times&quot;,&quot;serif&quot;;color:blue\">P"
                
                if utf8Text != ""{
                    let contentArray = utf8Text.components(separatedBy: stringSeparator)
                    
                    if contentArray.count > 0{
                        
                        stringSeparator = "</title>"
                        
                        let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                        if newContentArray.count > 0 {
                            
                            message = newContentArray[0]
                            if (message.range(of: "CN") != nil){
                                
                                newMessage = message.replacingOccurrences(of: "Tin Vui Xuân Lộc - LC_CN", with: "Chủ Nhật")
                                
                            } else if (message.range(of: "LC_1") != nil) {
                                newMessage = message.replacingOccurrences(of: "Tin Vui Xuân Lộc - LC_1", with: "Thứ ")
                                
                                
                            } else{
                                newMessage = message.replacingOccurrences(of: "Tin Vui Xuân Lộc - LC_T", with: "Thứ ")
                            }
                        }
                        DispatchQueue.main.async {
                            self.mainScreenImportantDate.text = newMessage
                        }
                        
                    }
                    
                    let contentArrayForPhucAm = utf8Text.components(separatedBy: stringSeparatorForPhucAm)
                    
                    if contentArrayForPhucAm.count > 0{
                        
                        //stringSeparatorForPhucAm = "<p class=\"MsoNormal\" style=\"text-align:justify\"><span style=\"font-family:&quot;Times&quot"
                        stringSeparatorForPhucAm = "<br />"
                        print(contentArrayForPhucAm.count)
                        print(contentArrayForPhucAm)
                        let newContentArray1 = contentArrayForPhucAm[1].components(separatedBy: stringSeparatorForPhucAm)
                        
                        
                        if newContentArray1.count > 0 {
                                self.phucAmMessage = newContentArray1[0]
                                self.phucAmMessage.insert(contentsOf: self.insertPhucAmText.characters, at: self.self.phucAmMessage.startIndex)
                                
                            }
        
                    }
                    
                    let contentArrayForBaiDoc = utf8Text.components(separatedBy: stringSeparatorForBaiDoc)
                    
                    if contentArrayForBaiDoc.count > 0{
                        
                        stringSeparatorForBaiDoc = "Alleluia.<o:p></o:p></span></p>"
                        
                        
                        let newContentArray2 = contentArrayForBaiDoc[1].components(separatedBy: stringSeparatorForBaiDoc)
                        if newContentArray2.count > 0 {
                            
                            self.baiDocMessage = newContentArray2[0]
                            self.baiDocMessage.insert(contentsOf: self.insertBaiDocText.characters, at: self.self.baiDocMessage.endIndex)
                            self.baiDocMessage.insert(contentsOf: self.insertBaiDocTextAtBegin.characters, at: self.self.baiDocMessage.startIndex)
                            
                        }
                    }
                    
                    let contentArrayForHomNayQuote = utf8Text.components(separatedBy: stringSeparatorForHomNayQuote)
                    
                    if contentArrayForHomNayQuote.count > 0{
                        
                        stringSeparatorForHomNayQuote = "><i><span style=\"font-size: 14pt; font-family: Times, serif;\">"
                        
                        
                        let newContentArray3 = contentArrayForHomNayQuote[1].components(separatedBy: stringSeparatorForHomNayQuote)
                        
                        let newContentArray4 = newContentArray3[1]
                        
                        stringSeparatorForHomNayQuote = ".</span></i><span style=\"font-size: 14pt;"
                        
                        let newContentArray5 = newContentArray4.components(separatedBy: stringSeparatorForHomNayQuote)
                        
                        
                        if newContentArray5.count > 0 {
                            
                            let formatString = newContentArray5[0]
                            let newString = formatString.replacingOccurrences(of: "\r\n", with: " ")
                            
                            self.homNayPhucAmQuote = newString
                            
                            DispatchQueue.main.async {
                                self.mainScreenQuoteLabel.text = self.homNayPhucAmQuote
                            }
                            
                            
                        }
                        
                    }
                
                
            }else{
                print("failled internet")
                self.mainScreenImportantDate.text = "Không thể kết nối đến internet"
                self.mainScreenQuoteLabel.text = ""
            }
        }
        
    }
}

override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
    
    let backItem = UIBarButtonItem()
    backItem.title = " "
    navigationItem.backBarButtonItem = backItem
}


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellTitles.count
}



func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
    
    cell.separatorInset = UIEdgeInsets.zero
    cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    cell.textLabel?.text = cellTitles[indexPath.row]
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.textColor = UIColor.white
    cell.layer.backgroundColor = UIColor.clear.cgColor
    cell.backgroundColor = .clear
    cell.selectionStyle = UITableViewCellSelectionStyle.blue
    return cell
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    if(indexPath.row == 5){
        
        let safariVC = SFSafariViewController(url: AUDIOBOOK_URL!)
        present(safariVC, animated: true, completion: nil)
        
    }
    
    
    if(indexPath.row == 4){
        
        performSegue(withIdentifier: "thanhCaSegue", sender: nil)
        
        
    }
    
    if(indexPath.row == 3){
        
        performSegue(withIdentifier: "kinhThanhSegue", sender: nil)
        
        
    }
    
    if(indexPath.row == 2){
        
        let safariVC = SFSafariViewController(url: baiGiangHomNay_URL!)
        present(safariVC, animated: true, completion: nil)
        
    }
    
    if(indexPath.row == 1){
        
        performSegue(withIdentifier: "phucAmSegue", sender: self)
        
        
    }
    
    if(indexPath.row == 0){
        performSegue(withIdentifier: "baiDocSegue", sender: self)
        
        
        
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
    
}



override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let PAviewController = segue.destination as? PhucAmViewController{
        
        PAviewController.phucAm = phucAmMessage
        
        //PAviewController.phucAm = sender as! String
        
    }
    if let BAviewController  = segue.destination as? BaiDocViewController{
        
        BAviewController.baiDoc = baiDocMessage
        
    }
}
}
