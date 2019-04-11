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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListItemCell") as! ToDoListItemCell
        cell.categoryTitle.text = modelData.categories![categoryIndex].itemList![indexPath.row].toDoName
        let url = URL(string: modelData.categories![categoryIndex].itemList![indexPath.row].toDoImageIcon)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.imageIcon.image = UIImage(data: data!)
        cell.imageIcon.contentMode = .scaleAspectFit
        cell.imageIcon.clipsToBounds = true
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modelData.categories![categoryIndex].itemList!.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addItemToDoList"){
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! ToDoItemDetailTableViewController
            destVC.delegate = self
            destVC.toDoCategoryList = categoryIndex
        }
    }
}

extension ToDoListItemTableViewController:ToDoDelegate{
    func didAddItem(controller: ToDoItemDetailTableViewController, itemAdded: ToDoItem, categoryIdString:String, image:UIImage) {
        dismiss(animated: true, completion: nil)
        storage.uploadImage(toDoItemAdded: itemAdded, image: image, categoryId: categoryIndex, tableView: self.tableView)
    }
    
    func cancel(controller: ToDoItemDetailTableViewController) {
        dismiss(animated: true, completion: nil)
    }
}
