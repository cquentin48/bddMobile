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
    var categories:[Categories]?
    var filteredCategories:[Categories]?
    
    static var documentDirectory:URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static var dataFileUrl:URL {
        return documentDirectory.appendingPathComponent("CheckLists").appendingPathExtension("json")
    }
    
    required init() {
        categories = [Categories]()
        filteredCategories = [Categories]()
        print("Data adresse : "+ModelData.dataFileUrl.absoluteString)
    }
    
    func saveChecklistItems(){
        savetoJSON()
        exportToFirebaseDatabase()
    }
    
    func savetoJSON(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do{
            let jsonData = try encoder.encode(categories)
            try jsonData.write(to: ModelData.dataFileUrl)
        }
        catch{}
    }
    
    func exportToFirebaseDatabase(){
        firebaseCloudFirestore.saveCategories()
    }
    
    func filterData(_ searchController:UISearchController){
        filteredCategories = categories!.filter({( category : Categories) -> Bool in
            return category.title!.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
    }
    
    func loadFromFirebase(){
        firebaseCloudFirestore.loadAllCategories()
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
