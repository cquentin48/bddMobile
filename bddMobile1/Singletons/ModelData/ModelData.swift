//
//  ModelData.swift
//  bddMobile1
//
//  Created by lpiem on 19/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
let modelData = ModelData()
class ModelData{
    //Catégories
    var categories:[Categories]?
    var filteredCategories:[Categories]?
    
    //ToDoItem
    var filteredToDoItem:[ToDoItem]?
    
    static var documentDirectory:URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func addToDoToCollectionList(categoryIndex:Int, toDoItem:ToDoItem){
        categories![categoryIndex].itemList!.append(toDoItem)
    }
    
    static var dataFileUrl:URL {
        return documentDirectory.appendingPathComponent("CheckLists").appendingPathExtension("json")
    }
    
    required init() {
        categories = [Categories]()
        filteredCategories = [Categories]()
        filteredToDoItem = [ToDoItem]()
        print("Data adresse : "+ModelData.dataFileUrl.absoluteString)
    }
    
    func loadCategoryTitles()->[String]{
        var categoryList = [String]()
        categories!.forEach { (category) in
            categoryList.append(category.title!)
        }
        return categoryList
    }
    
    func saveChecklistItems(){
        //savetoJSON()
        //exportToFirebaseDatabase()
    }
    
    /*func savetoJSON(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do{
            let jsonData = try encoder.encode(categories)
            try jsonData.write(to: ModelData.dataFileUrl)
        }
        catch{}
    }*/
    
    func exportToFirebaseDatabase(){
        firebaseCloudFirestore.saveCategories()
    }
    
    func filterData(_ searchController:UISearchController){
        filteredCategories = categories!.filter({( category : Categories) -> Bool in
            return category.title!.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
    }
    
    func filterToDoItem(_ searchController:UISearchController, categoryId:Int){
        filteredToDoItem = categories![categoryId].itemList!.filter({( toDoItem : ToDoItem) -> Bool in
            return toDoItem.toDoName.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
    }
    
    func loadFromFirebase(tableView: UITableView){
        firebaseCloudFirestore.loadCategoriesIfExist(tableView: tableView)
    }
    
    func removeCategoryFromFirebase(key:Int){
        firebaseCloudFirestore.removeElement(key: self.categories![key].id)
        categories?.remove(at: key)
    }
    
    /*func loadChecklistItems(){
        print("Chargement des items")
        do{
            let importedData = try Data(contentsOf: ModelData.dataFileUrl)
            categories = try JSONDecoder().decode([Categories].self, from: importedData)
            dump(categories)
        }catch{
            
        }
        dump(categories)
    }*/
}
