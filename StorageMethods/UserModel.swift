//
//  UserModel.swift
//  StorageMethods
//
//  Created by Next on 23/12/16.
//  Copyright © 2016 Next. All rights reserved.
//

import UIKit

class UserModel {
    var mName : String?
    var mAge : Int?
    init(with name: String, age : Int) {
        self.mName = name
        self.mAge = age
    }
}
