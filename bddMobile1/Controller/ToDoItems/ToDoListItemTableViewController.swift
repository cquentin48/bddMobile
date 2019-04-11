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
    var searchController:UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        initSearchController()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func returnAction(_ sender: Any) {
        delegate?.cancel(self)
    }
    
    func isFiltering() -> Bool{
        return searchController!.searchBar.text != "" && searchController!.isActive
    }
    
    func initSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController!.searchResultsUpdater = self
        searchController!.obscuresBackgroundDuringPresentation = false
        searchController!.searchBar.placeholder = "Rechercher un rappel"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListItemCell") as! ToDoListItemCell
        if(modelData.categories![categoryIndex].itemList!.count>0){
            if(isFiltering()){
                cell.initCell(toDo: modelData.filteredToDoItem![indexPath.row])
            }else{
                cell.initCell(toDo: modelData.categories![categoryIndex].itemList![indexPath.row])
            }
        }
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

extension ToDoListItemTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        if(isFiltering()){
            modelData.filterToDoItem(searchController, categoryId: categoryIndex)
        }
        tableView.reloadData()
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
