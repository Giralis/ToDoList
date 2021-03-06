//
//  TableViewController.swift
//  ToDoList
//
//  Created by Владимир Тимофеев on 31.05.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadContext()
        tableView.reloadData()
    }
    
    func loadContext() {
        var toDo = ToDoStr(name: "Welcome!", date: Date())
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoEntity")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                toDo.name = result.value(forKey: "name") as! String
                toDo.date = result.value(forKey: "date") as! Date
                toDos.append(toDo)
            }
        } catch {
            let nserror = error as NSError
            let alert = UIAlertController(title: "Error", message: "Unresolved error \(nserror), \(nserror.userInfo)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        for toDo in toDos {
            saveContext(name: toDo.name, date: toDo.date)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "You've got to do:"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
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

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToDo" {
            let indexPath = tableView.indexPathForSelectedRow!
            let toDo = toDos[indexPath.row]
            let navController = segue.destination
            let viewController = navController as! ViewController
            
            viewController.toDo = toDo
        }
    }

    
    @IBAction func unwindToEmojiTableViewController(segue: UIStoryboardSegue){
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source as? ViewController,
              let toDo = sourceViewController.toDo else {return}
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            toDos[selectedIndexPath.row] = toDo
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: toDos.count, section: 0)
            toDos.append(toDo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

    func saveContext(name: String, date: Date) {
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       let managedContext = appDelegate.persistentContainer.viewContext
       
       guard let entityDescription = NSEntityDescription.entity(forEntityName: "ToDoEntity", in: managedContext) else { return }
       let managedObject = NSManagedObject(entity: entityDescription, insertInto: managedContext)
       
       managedObject.setValue(name, forKey: "name")
       managedObject.setValue(date, forKey: "date")
       
       do {
           try managedContext.save()
       } catch {
           let nserror = error as NSError
           let alert = UIAlertController(title: "Error", message: "Unresolved error \(nserror), \(nserror.userInfo)", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
   }
}
