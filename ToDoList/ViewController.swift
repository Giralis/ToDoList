//
//  ViewController.swift
//  ToDoList
//
//  Created by Владимир Тимофеев on 30.05.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var addToDoButton: UIButton!
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateAddButtonState()
    }
    var toDo: ToDoStr?
    
    /* @IBAction func addToDoTapped(_ sender: UIButton) {
        guard let name = textField.text else { return }
        let date = datePicker.date
        
        toDo = ToDo(name: name, date: date)
        
        guard let toDoUnwrap = toDo else { return }
        toDos.append(toDoUnwrap)
        dates.append(toDoUnwrap.date)
        
    } */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toDo = toDo {
            textField.text = toDo.name
            datePicker.date = toDo.date
        }
        updateAddButtonState()
    }

    func updateAddButtonState() {
        let name = textField.text ?? ""
        addToDoButton.isEnabled = !name.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let name = textField.text ?? ""
        let date = datePicker.date
        
        toDo = ToDoStr(name: name, date: date)
    }

}

