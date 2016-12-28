//
//  SqliteVC.swift
//  StorageMethods
//
//  Created by Next on 23/12/16.
//  Copyright © 2016 Next. All rights reserved.
//

import UIKit

class SqliteVC: UIViewController {

    
    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var ageTxtFld: UITextField!
    
    @IBOutlet weak var userDetailsTableView: UITableView!
    var database : Database?
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Database.getInstance()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        if database != nil{
            
            if userNameTxtFld.text != nil && ageTxtFld.text != nil && userNameTxtFld.text?.characters.count != 0 && ageTxtFld.text?.characters.count != 0{
                
                database?.insertInToSqlite(name: userNameTxtFld.text!, age: Int(ageTxtFld.text!) ?? 0)
                userDetailsTableView.reloadData()
                userNameTxtFld.text = nil
                ageTxtFld.text = nil
            }
        }
    }

}
extension SqliteVC: UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if database != nil{
            users = (database?.getDetailsFromSqlite())!
        }
        return users.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "\(users[indexPath.row].mName!) \t\t \(users[indexPath.row].mAge!)"
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            if database != nil{
                let name = users[indexPath.row].mName!
                database?.deleteFromSqlite(name: name)
                userDetailsTableView.reloadData()
            }
            
        }
    }
    
}
