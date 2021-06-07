//
//  ViewController.swift
//  ToDoList
//
//  Created by Владимир Тимофеев on 30.05.2021.
//

import UIKit


class ViewController: UIViewController {

    
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var addToDoButton: UIButton!
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateAddButtonState()
    }
    var toDo: ToDo?
    
    @IBAction func addToDoTapped(_ sender: UIButton) {
        guard let name = textField.text else { return }
        let date = datePicker.date
        toDo = ToDo(name: name, date: date)
        guard let toDoUnwrap = toDo else { return }
        toDos.append(toDoUnwrap)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToDoButton.isEnabled = false
    }

    func updateAddButtonState() {
        let name = textField.text ?? ""
        addToDoButton.isEnabled = !name.isEmpty
    }

}

