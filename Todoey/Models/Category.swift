//
//  Category.swift
//  Todoey
//
//  Created by Doug Mason on 4/14/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object
{
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
}
