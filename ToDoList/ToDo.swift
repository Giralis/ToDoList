//
//  Cell.swift
//  ToDoList
//
//  Created by Владимир Тимофеев on 30.05.2021.
//

import Foundation

struct ToDoStr {
    var name: String
    var date: Date
    
    init(name: String, date: Date) {
        self.name = name
        self.date = date
    }
}
var toDos = [ToDoStr]()
var dates = [Date]()
