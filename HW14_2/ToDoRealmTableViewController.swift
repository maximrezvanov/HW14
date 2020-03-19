//
//  ToDoRealmTableViewController.swift
//  HW14_2
//
//  Created by MaximRezvanov on 3/13/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import RealmSwift

class TasksList: Object{
    @objc dynamic var task = ""
}


class ToDoRealmTableViewController: UITableViewController {
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        newAlert()
    }
    
    
    
    let realm = try! Realm()
    var items: Results<TasksList>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = realm.objects(TasksList.self)
        
    }

    func newAlert(){
        let alert = UIAlertController(title: "New task", message: "Please, add the text", preferredStyle: .alert)
        var alertTextField: UITextField!
        alert.addTextField{ textField in
            alertTextField = textField
            textField.placeholder = "New task"
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) {action in

            guard let text = alertTextField.text, !text.isEmpty else { return }
            let task = TasksList()
            task.task = text

            try! self.realm.write{
                self.realm.add(task)
            }

            self.tableView.insertRows(at: [IndexPath.init(row: self.items.count - 1, section: 0)], with: .automatic)

        }
        // кнопка для отмены ввода новой задачи
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil) // вызов алерта
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count != 0 {
         return items.count
        } else { return 0 }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.task
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let delete = deleteAction(at: indexPath)
           return UISwipeActionsConfiguration(actions: [delete])
       }

       func deleteAction(at indexPath: IndexPath) -> UIContextualAction {

           let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
               let editingRow = self.items[indexPath.row]
               try!self.realm.write{
                   self.realm.delete(editingRow)
                   self.tableView.reloadData()
               }
           }
           return action
       }
    

}
