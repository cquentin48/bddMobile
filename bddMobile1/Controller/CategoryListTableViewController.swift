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
    var filteredCategories:[Categories]?
    
    static var documentDirectory:URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static var dataFileUrl:URL {
        return documentDirectory.appendingPathComponent("CheckLists").appendingPathExtension("json")
    }
    
    func saveChecklistItems(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do{
            let jsonData = try encoder.encode(categories)
            try jsonData.write(to: CategoryListTableViewController.dataFileUrl)
        }
        catch{}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadChecklistItems()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! ItemDetailTableViewController
            destVC.delegate = self
        }else if segue.identifier == "editItem" {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! ItemDetailTableViewController
            destVC.delegate = self
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            destVC.index = indexPath.row
            destVC.item = categories![indexPath.row]
        }
    }
    
    func isFiltering() -> Bool{
        return searchController.searchBar.text != "" && searchController.isActive
    }
    
    func filterData(){
        filteredCategories = categories!.filter({( category : Categories) -> Bool in
            return category.title!.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        
    }
    
    func loadChecklistItems(){
        print("Chargement des items")
        do{
            let importedData = try Data(contentsOf: CategoryListTableViewController.dataFileUrl)
            categories = try JSONDecoder().decode([Categories].self, from: importedData)
            dump(categories)
        }catch{
            
        }
        dump(categories)
    }
    
    func getElementByInputText(inputElement: Categories)-> Int{
        for i in 0...categories!.count-1 {
            if categories![i].title == inputElement.title{
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
        // #warning Incomplete implementation, return the number of rows
        if(isFiltering()){
            return filteredCategories!.count
        }else{
            return categories!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath) as! CategoryCell
        if(isFiltering()){
            cell.initCell(categoryName: filteredCategories![indexPath.row].title!, isChecked: false)
        }else{
            cell.initCell(categoryName: categories![indexPath.row].title!, isChecked: false)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            categories?.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .automatic)
            saveChecklistItems()
        }
    }

}

extension CategoryListTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        if(isFiltering()){
            filterData()
        }else{
        }
        tableView.reloadData()
    }
}

extension CategoryListTableViewController: ItemDetailViewControllerDelegate{
    func itemViewControllerDidCancel(_ controller: ItemDetailTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishAddingItem item: Categories) {
        table.beginUpdates()
        categories?.append(item)
        table.insertRows(at: [IndexPath(row: categories!.count-1, section: 0)], with: .automatic)
        table.endUpdates()
        saveChecklistItems()
        controller.dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishEditingItem item: Categories, indexAt: Int) {
        table.beginUpdates()
        categories![indexAt] = item
        
        table.reloadRows(at: [IndexPath(row: indexAt, section: 0)], with: .automatic)
        table.endUpdates()
        saveChecklistItems()
        dismiss(animated: true, completion: nil)
    }
}
