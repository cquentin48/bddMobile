//
//  CategoryListTableViewController.swift
//  bddMobile1
//
//  Created by lpiem on 22/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class CategoryListTableViewController: UITableViewController {
    var searchController:UISearchController?
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchController()
        loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSearchController()
    }
    
    func loadData(){
        modelData.loadFromFirebase(tableView: table)
    }
    
    func initSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController!.searchResultsUpdater = self
        searchController!.obscuresBackgroundDuringPresentation = false
        searchController!.searchBar.placeholder = "Rechercher une catégorie"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! CategoryDetailTableViewController
            destVC.delegate = self
        }else if segue.identifier == "editItem" {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! CategoryDetailTableViewController
            destVC.delegate = self
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            destVC.index = indexPath.row
            destVC.item = modelData.categories![indexPath.row]
        }
    }
    
    func isFiltering() -> Bool{
        return searchController!.searchBar.text != "" && searchController!.isActive
    }
    
    func getElementByInputText(inputElement: Categories)-> Int{
        for i in 0...modelData.categories!.count-1 {
            if modelData.categories![i].title == inputElement.title{
                return i
            }
        }
        return -1
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isFiltering()){
            return modelData.filteredCategories!.count
        }else{
            return modelData.categories!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath) as! CategoryCell
        if(modelData.categories!.count>0){
            if(isFiltering()){
                cell.initCell(categoryName: modelData.filteredCategories![indexPath.row].title!, isChecked: false)
            }else{
                cell.initCell(categoryName: modelData.categories![indexPath.row].title!, isChecked: false)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            modelData.removeCategoryFromFirebase(key: indexPath.row)
            table.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension CategoryListTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        if(isFiltering()){
            modelData.filterData(searchController)
        }else{
        }
        tableView.reloadData()
    }
}

extension CategoryListTableViewController: ItemDetailViewControllerDelegate{
    func itemViewControllerDidCancel(_ controller: CategoryDetailTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: CategoryDetailTableViewController, didFinishAddingItem item: Categories) {
        table.beginUpdates()
        modelData.categories?.append(item)
        table.insertRows(at: [IndexPath(row: modelData.categories!.count-1, section: 0)], with: .automatic)
        table.endUpdates()
        modelData.saveChecklistItems()
        firebaseCloudFirestore.addCategories(category: item)
        controller.dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: CategoryDetailTableViewController, didFinishEditingItem item: Categories, indexAt: Int) {
        table.beginUpdates()
        modelData.categories![indexAt] = item
        
        table.reloadRows(at: [IndexPath(row: indexAt, section: 0)], with: .automatic)
        table.endUpdates()
        modelData.saveChecklistItems()
        controller.dismiss(animated: true, completion: nil)
    }
}
