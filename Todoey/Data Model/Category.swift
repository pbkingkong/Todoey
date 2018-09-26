//
//  Category.swift
//  Todoey
//
//  Created by Peter Buzek on 19.09.18.
//  Copyright © 2018 Peter Buzek. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String = ""
    @objc dynamic var colour:String = ""
    
    let items = List<Item>()
    
}
