//
//  CategoryListTableViewController.swift
//  bddMobile1
//
//  Created by lpiem on 22/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class CategoryListTableViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet var table: UITableView!
    var categories:[Categories]?
    override func viewDidLoad() {
        super.viewDidLoad()
        initArray()
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Rechercher une catégorie"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func initArray(){
        categories = [Categories]()
        categories?.append(Categories(title: "Histoire - géo"))
        categories?.append(Categories(title: "Français"))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let navVC = segue.destination as! ItemViewViewController
            navVC.delegate = self
            navVC.item = nil
        }else if segue.identifier == "editItem" {
            let navVC = segue.destination as! ItemViewViewController
            navVC.delegate = self
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            navVC.item = categories![indexPath.row]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (categories?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)
        cell.textLabel?.text = categories![indexPath.row].title
        return cell
    }

}

extension CategoryListTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}

extension CategoryListTableViewController: ItemDetailViewControllerDelegate{
    func itemViewControllerDidCancel(_ controller: ItemViewViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemViewViewController, didFinishAddingItem item: Categories) {
        table.beginUpdates()
        categories?.append(item)
        table.insertRows(at: [IndexPath(row: categories!.count-1, section: 0)], with: .automatic)
        table.endUpdates()
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemViewViewController, didFinishEditingItem item: Categories, indexAt: Int) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
