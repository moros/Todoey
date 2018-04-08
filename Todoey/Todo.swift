//
//  Todo.swift
//  Todoey
//
//  Created by Doug Mason on 4/8/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import Foundation

class Todo
{
    var value : String?
    var selected : Bool = false
    
    init (value : String)
    {
        self.value = value
    }
}
