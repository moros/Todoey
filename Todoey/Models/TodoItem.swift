//
//  Todo.swift
//  Todoey
//
//  Created by Doug Mason on 4/8/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import Foundation

class TodoItem
{
    var title : String?
    var done : Bool = false
    
    init (title : String)
    {
        self.title = title
    }
}
