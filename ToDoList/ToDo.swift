//
//  Cell.swift
//  ToDoList
//
//  Created by Владимир Тимофеев on 30.05.2021.
//

import Foundation

struct ToDo {
    var name: String
    var date: Date
    
    init(name: String, date: Date) {
        self.name = name
        self.date = date
    }
}
var firstTask = ToDo(name: "Enjoy the App", date: Date())
var toDos = [firstTask]
var dates = [firstTask.date]
var color = true
