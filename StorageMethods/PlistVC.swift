//
//  PlistVC.swift
//  StorageMethods
//
//  Created by Next on 23/12/16.
//  Copyright © 2016 Next. All rights reserved.
//

import UIKit

class PlistVC: UIViewController {

    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var ageTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        getDataFromPList()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDataFromPList() {
        guard let path = Bundle.main.path(forResource: "UserInfo", ofType: "plist") else {
            return
        }
        
        guard let dict = NSDictionary(contentsOfFile: path) else {
            return
        }
        
        
        let userData = dict.object(forKey: "information") as? [[String : String]] ?? [[String : String]]()
        for i in userData{
            print(i)
        }
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
      getDataFromPList()
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        guard let path = Bundle.main.path(forResource: "UserInfo", ofType: "plist") else {
            return
        }
        
        if userNameTxtFld.text != nil && ageTxtFld.text != nil{
            
            guard let dict = NSMutableDictionary(contentsOfFile: path) else {
                return
            }
            
//            
//            var userData = dict.object(forKey: "information") as? [[String : String]] ?? [[String : String]]()
//            
//            var tempDict = [String : String]()
//            tempDict["username"] = userNameTxtFld.text
//            tempDict["age"] = ageTxtFld.text
//            
//            userData.append(tempDict)
//            dict.setValue(userData, forKey: "information")
//            
//            dict.write(toFile: path, atomically: true)
            
            let userData = dict.object(forKey: "information") as? NSMutableArray
            
            let tempDict = NSDictionary(objects: [userNameTxtFld.text ?? "none",ageTxtFld.text ?? "0"], forKeys: ["username" as NSCopying,"age" as NSCopying])
            
            userData?.add(tempDict)
            dict.setValue(userData, forKey: "information")
            dict.write(toFile: path, atomically: true)
        }
    }
}
