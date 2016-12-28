//
//  Database.swift
//  StorageMethods
//
//  Created by Next on 23/12/16.
//  Copyright © 2016 Next. All rights reserved.
//

import UIKit
import FMDB
class Database: NSObject {

    
    static var instance : Database?
    var database : FMDatabase?

    class func getInstance() -> Database
    {
        if instance == nil
        {
            instance=Database()
        }
        return instance!
    }
    
    override init()
    {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                          .userDomainMask,
                                                          true)
        
        let dataBasePath = dirPath[0] + "/StorageMethods.sqlite"
        database = FMDatabase(path: dataBasePath)
        if (database?.open())! {
            
            //sql query to create category table
            let sql = "CREATE TABLE IF NOT EXISTS USERS (UserName TEXT PRIMARY KEY,Age INTEGER)"
            
            //create category table table
            if (!(database?.executeStatements(sql))!){
                print("Error : \(database?.lastErrorMessage())")
            }
            
            database?.close()
        }
        else {
            print("failed to open db \(database?.lastErrorMessage())")
        }
    }
    
    func insertInToSqlite(name: String, age: Int) {
        if database != nil{
            if (database?.open())! {
                let insertSql = "INSERT INTO USERS (UserName,Age) VALUES ('\(name)','\(age)')"
                if (database?.executeStatements(insertSql))! {
                    print("Data inserted")
                }
                else {
                    print("Failed to insert values into table")
                }
                database?.close()
            }
        }
    }
    
    func getDetailsFromSqlite() -> [UserModel] {
        
        var users = [UserModel]()
        if database != nil{
            
            if (database?.open())! {
                //fetch query
                let querySql = "SELECT * FROM USERS"
                let result = database?.executeQuery(querySql,
                                                    withArgumentsIn: nil)
                if (result != nil) {
                    while result!.next() {
                        let temp = UserModel(with: result!.string(forColumn: "UserName"), age: Int((result?.int(forColumn: "Age"))!))
                        users.append(temp)
                    }
                }
                else {
                    print("database is empty")
                }
                database?.close()
            }}
        return users
    }
    
    func deleteFromSqlite(name: String) {
        if database != nil{
            
            if (database?.open())! {
                
                let querySql = "DELETE FROM USERS WHERE UserName = '\(name)'"
                let result = database?.executeStatements(querySql)
                if result != nil{
                    print("delted")
                }
                else {
                    print("not deleted")
                }
                database?.close()
            }}
    }
    
}
