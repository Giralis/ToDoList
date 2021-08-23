//
//  TableViewController.swift
//  ToDoList
//
//  Created by Владимир Тимофеев on 31.05.2021.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if color {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .green
            color.toggle()
        } else {
            color.toggle()
            tableView.cellForRow(at: indexPath)?.backgroundColor = .white
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "You've got to do:"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
        
        
        let toDo = toDos[indexPath.row]
        
        cell.update(with: toDo)
        cell.showsReorderControl = true
            
        return cell
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
          let movedCell = toDos.remove(at: sourceIndexPath.row)
          toDos.insert(movedCell, at: destinationIndexPath.row)
          tableView.reloadData()
      }

    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Initial" {
            let indexPath = tableView.indexPathForSelectedRow!
            let toDo = toDos[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let ViewController = navController.topViewController as! ViewController
            
            ViewController.toDo = toDo
        }
    } */

    
    @IBAction func unwindToEmojiTableViewController(segue: UIStoryboardSegue){
        guard segue.identifier == "Initial",
              let sourceViewController = segue.source as? ViewController,
              let toDo = sourceViewController.toDo else {return}
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            toDos[selectedIndexPath.row] = toDo
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: toDos.count, section: 1)
            toDos.append(toDo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }



}
