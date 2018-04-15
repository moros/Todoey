//
//  Data.swift
//  Todoey
//
//  Created by Doug Mason on 4/15/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import Foundation
import RealmSwift

class Data : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age: Int = 0
}
