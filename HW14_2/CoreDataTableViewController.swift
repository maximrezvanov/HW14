//
//  CoreDataTableViewController.swift
//  HW14_2
//
//  Created by MaximRezvanov on 3/13/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import CoreData


class CoreDataTableViewController: UITableViewController {
    
    var toDoList: [Task] = []
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Add task", message: "add new task", preferredStyle:.alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            let textField = ac.textFields?[0]
            self.saveTask(taskToDo: (textField?.text)!)
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        ac.addTextField {
            UITextField in
        }
        
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
        
    }
    
    func saveTask(taskToDo: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
        taskObject.taskToDo = taskToDo
        
        do {
            try context.save()
            toDoList.append(taskObject)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do{
            toDoList = try context.fetch(fetchRequest)
        } catch {
            print (error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if toDoList.count != 0{
        return toDoList.count
        } else {return 0}
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        let task = toDoList[indexPath.row]
        cell.textLabel?.text = task.taskToDo
        return cell
    }



    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)

        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            let editingRow = self.toDoList[indexPath.row]
            context.delete(editingRow)
            self.toDoList.remove(at: indexPath.row)
            print("Task - \((editingRow.taskToDo)!) was completed!")

            do {
                try context.save()
                self.tableView.reloadData()
            } catch {
                print("error : \(error)")
            }
            
        }
        
        return action
    }

}
