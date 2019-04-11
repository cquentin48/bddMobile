//
//  ToDoListItemTableViewController.swift
//  bddMobile1
//
//  Created by lpiem on 09/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

protocol ToDoListItemDelegate {
    func cancel(_ controller:ToDoListItemTableViewController)
}

class ToDoListItemTableViewController: UITableViewController {
    var delegate:ToDoListItemDelegate?
    var categoryIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modelData.categories![categoryIndex].itemList!.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addItem"){
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! ToDoItemDetailTableViewController
            destVC.delegate = self
            destVC.toDoCategoryList = categoryIndex
        }
    }

}

extension ToDoListItemTableViewController:ToDoDelegate{
    func didAddItem(controller: ToDoItemDetailTableViewController, itemAdded: ToDoItem, categoryId:String) {
        dismiss(animated: true, completion: nil)
        firebaseCloudFirestore.addToDoItem(toDoItem: itemAdded, categoryId: categoryId)
    }
    
    func cancel(controller: ToDoItemDetailTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
