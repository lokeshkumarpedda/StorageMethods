//
//  CoreDataVC.swift
//  StorageMethods
//
//  Created by Next on 23/12/16.
//  Copyright © 2016 Next. All rights reserved.
//

import UIKit
import  CoreData

class CoreDataVC: UIViewController {

    
    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var ageTxtFld: UITextField!
    @IBOutlet weak var searchTxtFld: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        if userNameTxtFld.text != nil && ageTxtFld.text != nil && userNameTxtFld.text?.characters.count != 0 && ageTxtFld.text?.characters.count != 0{
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let user = UserDetails(context: context)
            user.userName = userNameTxtFld.text
            user.age = Int32(ageTxtFld.text!) ?? 0
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            userNameTxtFld.text = nil
            ageTxtFld.text = nil
        }
        
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        if searchTxtFld.text != nil && searchTxtFld.text?.characters.count != 0{
            let userArray = searchInCoreData(word: searchTxtFld.text!)
            if userArray.count == 0{
                
                ageLabel.text = "Not Found"
                nameLabel.text = searchTxtFld.text
            }
            else{
                nameLabel.text = userArray[0].userName
                ageLabel.text = String(userArray[0].age)
            }
            
        }
    }

    @IBAction func removeButtonPressed(_ sender: UIButton) {
        if searchTxtFld.text != nil && searchTxtFld.text?.characters.count != 0{
            removeFromCoreData(word: searchTxtFld.text!)
        }
    }
    
    
    //searching in the core data
    func searchInCoreData(word : String) -> [UserDetails] {
        var detailsArray : [UserDetails]?
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            //                let userArray : [UserDetails] = try context.fetch(UserDetails.fetchRequest())
            
            let predicate = NSPredicate(format: "userName = %@", searchTxtFld.text!)
            let fetchReq : NSFetchRequest = UserDetails.fetchRequest()
            fetchReq.predicate = predicate
            detailsArray = try context.fetch(fetchReq)
            
        }catch{
            print("fetching failed")
        }
        return detailsArray ?? [UserDetails]()
    }
    
    
    //removing from the coredata
    func removeFromCoreData(word : String) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            let predicate = NSPredicate(format: "userName = %@", searchTxtFld.text!)
            let fetchReq : NSFetchRequest = UserDetails.fetchRequest()
            fetchReq.predicate = predicate
            let userArray : [UserDetails] = try context.fetch(fetchReq)
            if userArray.count == 0{
                
                ageLabel.text = "Not Found"
                nameLabel.text = searchTxtFld.text
            }
            else{
                
                context.delete(userArray[0])
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                nameLabel.text = searchTxtFld.text
                ageLabel.text = "removed"
            }
            
        }catch{
            print("fetching failed")
        }
    }

}
