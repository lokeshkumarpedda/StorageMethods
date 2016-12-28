//
//  ViewController.swift
//  StorageMethods
//
//  Created by Next on 23/12/16.
//  Copyright © 2016 Next. All rights reserved.
//

import UIKit

class UserDefaultsVC: UIViewController {
    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var ageTxtFld: UITextField!
    @IBOutlet weak var searchTxtFld: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addButton(_ sender: UIButton) {
        
        if userNameTxtFld.text != nil && ageTxtFld.text != nil && ageTxtFld.text?.characters.count != 0 && userNameTxtFld.text?.characters.count != 0{
            
            defaults.set(ageTxtFld.text, forKey: userNameTxtFld.text!)
            userNameTxtFld.text = nil
            ageTxtFld.text = nil
        }
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        if searchTxtFld.text != nil && searchTxtFld.text?.characters.count != 0{
            
            if let result = defaults.object(forKey: searchTxtFld.text!){
                
                nameLabel.text = searchTxtFld.text
                ageLabel.text = result as? String
                
            }
            else{
                
                nameLabel.text = searchTxtFld.text
                ageLabel.text = "Not found"
                
            }
        }
        
    }
    
    @IBAction func removeButton(_ sender: UIButton) {
        
        if searchTxtFld.text != nil && (defaults.object(forKey: searchTxtFld.text!) != nil) && searchTxtFld.text?.characters.count != 0{
            
            defaults.removeObject(forKey: searchTxtFld.text!)
            ageLabel.text = "removed"
            
        }
        else {
            ageLabel.text = "Not found"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

