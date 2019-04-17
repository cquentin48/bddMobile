//
//  Database.swift
//  bddMobile1
//
//  Created by lpiem on 01/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import Firebase
let firebaseCloudFirestore = FirebaseDatabase()
class FirebaseDatabase{
    var db: DatabaseReference! = Database.database().reference()
    var categoriesLoaded:Bool = false
    var toDoItemLoaded:Bool = false
    var collectionRef:DatabaseReference
    var toDoRef:DatabaseReference
    
    func saveCategories(){
        modelData.categories!.enumerated().map{ (index, singleCategory) in
            addCategories(category: singleCategory)
        }
    }
    
    required init() {
        collectionRef = db.child("collection")
        toDoRef = db.child("toDoItems")
    }
    
    func addCategories(category:Categories){
        category.id = generateKey(ref: collectionRef)
        let categoryRef = collectionRef.child(category.id).setValue([
            "title" : category.title,
            "description" : category.description,
            "image" : category.image,
            "authorId" : category.authorId,
            "isChecked" : category.isChecked
        ])
    }
    
    func addToDoItem(toDoItem:ToDoItem, categoryId:String){
        toDoItem.toDoKey = generateKey(ref: toDoRef)
        let toDoItemRef = toDoRef.child(toDoItem.toDoKey).setValue([
            "title" : toDoItem.toDoName,
            "description" : toDoItem.toDoDescription,
            "reminder" : toDoItem.generateStringFromDate(rawDate: toDoItem.toDoRemindDate),
            "creationDate" : toDoItem.generateStringFromDate(rawDate: toDoItem.toDoCreationDate),
            "lastModificationDate" : toDoItem.generateStringFromDate(rawDate: toDoItem.toDoLastModificationDate),
            "categoryId" : categoryId,
            "imageURL" : toDoItem.toDoImageIcon
            ])
    }
    
    func removeToDoItem(key:String){
        let toDoItemRef = toDoRef.child(key)
        toDoItemRef.removeValue{ error, _ in
            if(error != nil){
                print("Element supprimé")
            }else{
                print("Error"+error.debugDescription)
            }
        }
    }
    
    func generateKey(ref:DatabaseReference)->String{
        return ref.childByAutoId().key!
    }
    
    func removeCategories(key:String){
        let elementRef = collectionRef.child(key)
        elementRef.removeValue{ error, _ in
            if(error != nil){
                print("Catégorie supprimée")
            }else{
                print("Error"+error.debugDescription)
            }
        }
    }
    
    func loadCategoriesIfExist(tableView : UITableView){
        self.loadAllCategories(tableView: tableView)
    }
    
    func loadAllCategories(tableView : UITableView){
        modelData.categories = [Categories]()
        let ref = collectionRef.queryOrdered(byChild: "authorId").queryEqual(toValue: Auth.auth().currentUser?.uid).observe(.value, with: {(snapshot) in
            let categories = snapshot.value as? NSDictionary
            let categoriesKey = categories?.allKeys as! Array<String>
            categoriesKey.forEach{(singleKey) in
               modelData.categories?.append(self.addCategoryToList(rawData: categories?.object(forKey: singleKey) as! NSDictionary, index: singleKey))
                if(modelData.categories?.count == categories?.count){
                    self.categoriesLoaded = true
                }
            }
            DispatchQueue.main.async {
                self.reloadData(tableView: tableView)
                print("ljklj")
            }
            self.collectionRef.removeAllObservers()
        }) {(error) in
            print("Error : ", error)
        }
        
    }
    
    private func reloadData(tableView:UITableView){
        tableView.reloadData()
    }
    
    func loadAllItems(tableView: UITableView, categoryId:Int){
        modelData.categories![categoryId].itemList = [ToDoItem]()
        toDoRef.queryOrdered(byChild: "categoryId").queryEqual(toValue: modelData.categories![categoryId].id).observe(.value, with: {(snapshot) in
            let toDoList = snapshot.value as? NSDictionary
            let toDoListKey = toDoList?.allKeys as! Array<String>
            toDoListKey.forEach{(singleKey) in
                modelData.categories?.append(self.addCategoryToList(rawData: toDoList?.object(forKey: singleKey) as! NSDictionary, index: singleKey))
                if(modelData.categories?.count == toDoList?.count){
                    self.categoriesLoaded = true
                }
            }
            DispatchQueue.main.async {
                self.reloadData(tableView: tableView)
            }
            self.collectionRef.removeAllObservers()
        }) {(error) in
            print("Error : ", error)
        }
    }
    
    func removeElement(key:String){
        collectionRef.child(key).removeValue()
    }
    
    func addToDoList(rawData:NSDictionary, index:String)->ToDoItem{
       var toDo = ToDoItem()
       toDo = ToDoItem(toDoName: getObjectFromKey(rawData: rawData, key: "title") as! String,
                           toDoDescription: getObjectFromKey(rawData: rawData, key: "description") as! String,
                           toDoRemindDate: toDo.generateDateFromString(rawDate: getObjectFromKey(rawData: rawData, key: "reminder") as! String),
                           toDoCreationDate: toDo.generateDateFromString(rawDate: getObjectFromKey(rawData: rawData, key: "creationDate") as! String),
                           toDoLastModificationDate: toDo.generateDateFromString(rawDate: getObjectFromKey(rawData: rawData, key: "lastModificationDate") as! String),
                           toDoImageIcon: getObjectFromKey(rawData: rawData, key: "imageURL") as! String,
                           toDoKey: index)
        return toDo
    }
    
    private func getObjectFromKey(rawData:NSDictionary, key:String)->Any{
        return rawData.object(forKey: key)!
    }
    
    func addCategoryToList(rawData:NSDictionary, index:String)->Categories{
        let category = Categories(title: rawData.object(forKey: "title") as! String,
                                  isChecked: rawData.object(forKey: "isChecked") as! Bool,
                                  image: rawData.object(forKey: "image") as! String,
                                  description: rawData.object(forKey: "description") as! String,
                                  id: index,
                                  authorId: rawData.object(forKey: "authorId") as! String)
        return category
    }
}
